package controller

import (
	"auth-service/dal"
	"database/sql"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
)

type NewPostBody struct {
	Title    *string `json:"title,omitempty"`
	Body     *string `json:"body,omitempty"`
	PosterID *int    `json:"posterID,omitempty"`
}

func NewPost(w http.ResponseWriter, r *http.Request) {
	// start by getting all posts
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)

	// get post form body
	var post NewPostBody
	err := json.NewDecoder(r.Body).Decode(&post)

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
	)

	if err != nil {
		// handle various errors

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
