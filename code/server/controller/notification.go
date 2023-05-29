package controller

import (
	"auth-service/dal"
	"database/sql"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
)

func GetNotificationsForUser(w http.ResponseWriter, r *http.Request) {
	// serialize the id from the query params
	id := chi.URLParam(r, "id")
	post_id, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		http.Error(w, "Invalid ID.", http.StatusBadRequest)
		return
	}

	query_params := r.URL.Query()
	is_read_str := query_params.Get("is_read")
	is_read, err := strconv.ParseBool(is_read_str)
	if err != nil {
		http.Error(w, "Invalid query params.", http.StatusBadRequest)
		return
	}

	// get the DB from the context
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	post, err := dal.GetNotifications(db, int(post_id), is_read)
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

type newNotificationBody struct {
	PostID  *int `json:"postID,omitempty"`
	ActorID *int `json:"actorID,omitempty"`
}

func NewNotification(w http.ResponseWriter, r *http.Request) {
	// start by getting all posts
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)

	// get notification form body
	var notification newNotificationBody
	err := json.NewDecoder(r.Body).Decode(&notification)

	// check for improper data
	if err != nil {
		http.Error(w, "Incorrect body.", http.StatusBadRequest)
		return
	}

	if notification.PostID == nil {
		http.Error(w, "Missing post.", http.StatusBadRequest)
		return
	}

	if notification.ActorID == nil {
		http.Error(w, "Missing actor.", http.StatusBadRequest)
		return
	}

	new_notification, err := dal.NewNotification(
		db,
		*notification.PostID,
		*notification.ActorID,
	)

	if err != nil {
		// handle various errors
		if err.Error() == "pq: actor and poster cannot be the same" {
			http.Error(w, "actor and poster cannot be the same person", http.StatusBadRequest)
			return
		}

		if err.Error() == "pq: insert or update on table \"notification\" violates foreign key constraint \"notification_actor_id_fkey\"" {
			http.Error(w, "receiver person does not exist", http.StatusBadRequest)
			return
		}

		if err.Error() == "pq: null value in column \"reciever_id\" of relation \"notification\" violates not-null constraint" {
			http.Error(w, "post does not exist", http.StatusBadRequest)
			return
		}

		if err.Error() == "pq: duplicate key value violates unique constraint \"unique_post_actor_combo\"" {
			http.Error(w, "notification already exists", http.StatusBadRequest)
			return
		}

		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	new_notification_res, err := json.Marshal(new_notification)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write(new_notification_res)
}
