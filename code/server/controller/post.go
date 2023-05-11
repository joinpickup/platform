package controller

import (
	"auth-service/dal"
	"auth-service/model"
	"database/sql"
	"encoding/json"
	"net/http"
)

func NewPost(w http.ResponseWriter, r *http.Request) {
	// start by getting all posts
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)

	// get post form body
	var post model.Post
	err := json.NewDecoder(r.Body).Decode(&post)

	// check for improper data
	if err != nil {
		http.Error(w, "Incorrect body.", http.StatusBadRequest)
		return
	}

	if post.Title == "" {
		http.Error(w, "Missing title.", http.StatusBadRequest)
		return
	}

	if post.Body == "" {
		http.Error(w, "Missing body.", http.StatusBadRequest)
		return
	}

	if post.PosterID == 0 {
		http.Error(w, "Missing poster.", http.StatusBadRequest)
		return
	}

	newPost, err := dal.NewPost(
		db,
		post,
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
	// start by getting all posts
	// db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write([]byte("test"))
}
