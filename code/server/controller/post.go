package controller

import (
	"auth-service/dal"
	"database/sql"
	"encoding/json"
	"io/ioutil"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
)

type NewPostBody struct {
	Title     *string `json:"title,omitempty"`
	Body      *string `json:"body,omitempty"`
	PosterID  *int    `json:"posterID,omitempty"`
	Interests []int   `json:"interests,omitempty"`
}

func NewPost(w http.ResponseWriter, r *http.Request) {
	// start by getting all posts
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)

	// get post form body
	var post NewPostBody
	defer r.Body.Close()
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		http.Error(w, "Failed to read request body", http.StatusInternalServerError)
		return
	}

	// this is a complete hack, but oh well
	// for some reason the dart code has a tendency to over escape, so here we are
	// TODO: this should be handled in the frontend
	body_unescaped, _ := strconv.Unquote(string(body))
	err = json.Unmarshal([]byte(body_unescaped), &post)

	// check for improper data
	if err != nil {
		http.Error(w, "Incorrect body.", http.StatusBadRequest)
		return
	}

	if post.Title == nil {
		http.Error(w, "Missing title.", http.StatusBadRequest)
		return
	}

	if post.Body == nil {
		http.Error(w, "Missing body.", http.StatusBadRequest)
		return
	}

	if post.PosterID == nil {
		http.Error(w, "Missing poster.", http.StatusBadRequest)
		return
	}

	newPost, err := dal.NewPost(
		db,
		*post.Title,
		*post.Body,
		*post.PosterID,
		post.Interests,
	)

	if err != nil {
		// handle various errors
		// TODO: add tags
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	newPostRes, err := json.Marshal(newPost)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write(newPostRes)
}

func GetPosts(w http.ResponseWriter, r *http.Request) {
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	posts, err := dal.GetPostsForUser(db, 1)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	posts_str, err := json.Marshal(posts)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write(posts_str)
}

type updateBody struct {
	Body *string `json:"body,omitempty"`
}

func UpdatePost(w http.ResponseWriter, r *http.Request) {
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	id := chi.URLParam(r, "id")
	id_int, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		http.Error(w, "Invalid ID.", http.StatusBadRequest)
		return
	}

	var update_body updateBody
	err = json.NewDecoder(r.Body).Decode(&update_body)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	updated_post, err := dal.UpdatePost(db, int(id_int), update_body.Body)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	if updated_post == nil {
		http.Error(w, "No post with that ID", http.StatusNotFound)
		return
	}

	updated_post_str, err := json.Marshal(updated_post)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write(updated_post_str)
}

type interestPostBody struct {
	InterestID *int `json:"interestID,omitempty"`
}

func AddInterestForPost(w http.ResponseWriter, r *http.Request) {

	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)

	id := chi.URLParam(r, "id")
	post_id, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		http.Error(w, "Invalid ID.", http.StatusBadRequest)
		return
	}

	var interest_body interestPostBody
	err = json.NewDecoder(r.Body).Decode(&interest_body)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	if interest_body.InterestID == nil {
		http.Error(w, "No interestID specified.", http.StatusBadRequest)
		return
	}

	err = dal.AddInterestForPost(db, int(post_id), *interest_body.InterestID)

	if err != nil {
		// Returned if the post doesn't exist
		if err.Error() == "pq: insert or update on table \"post_interest\" violates foreign key constraint \"post_interest_post_id_fkey\"" {
			http.Error(w, "No post exists with that ID", http.StatusNotFound)
			return
		}

		// Returned if the interest doesn't exist
		if err.Error() == "pq: insert or update on table \"post_interest\" violates foreign key constraint \"post_interest_interest_id_fkey\"" {
			http.Error(w, "No interest exists with that ID", http.StatusNotFound)
			return
		}

		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// set header and return
	w.WriteHeader(201)
	w.Header().Add("Content-Type", "application/json")
	w.Write([]byte{})
}

func GetPost(w http.ResponseWriter, r *http.Request) {
	// serialize the id from the query params
	id := chi.URLParam(r, "id")
	post_id, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		http.Error(w, "Invalid ID.", http.StatusBadRequest)
		return
	}

	// get the DB from the context
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	post, err := dal.GetPost(db, int(post_id))
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// marshal the post to return to the caller
	post_marsh, err := json.Marshal(post)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// return back the item
	w.WriteHeader(200)
	w.Header().Add("Content-Type", "application/json")
	w.Write(post_marsh)
}

func SearchPosts(w http.ResponseWriter, r *http.Request) {
	// Get the values of the "interest" and "space" query parameters
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	interest_values := r.URL.Query()["interest"]
	space_values := r.URL.Query()["space"]
	query := r.URL.Query().Get("query")

	// Convert the query parameter values to integers
	var interests, spaces []int
	for _, interest := range interest_values {
		id, err := strconv.Atoi(interest)
		if err == nil {
			interests = append(interests, id)
		}
	}

	for _, space := range space_values {
		id, err := strconv.Atoi(space)
		if err == nil {
			spaces = append(spaces, id)
		}
	}

	// Perform the search operation using the interests and spaces
	posts, err := dal.SearchPosts(db, spaces, interests, query)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// ... Your search logic goes here ...
	// Create a response object with the search results
	w.Header().Set("Content-Type", "application/json")

	// Encode the response object as JSON and write it to the response
	json.NewEncoder(w).Encode(posts)
}
