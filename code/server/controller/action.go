package controller

import (
	"auth-service/dal"
	"database/sql"
	"encoding/json"
	"log"
	"net/http"

	"github.com/gorilla/websocket"
)

type messageBody struct {
	Message *string `json:"message,omitempty"`
	PostID  *int    `json:"postID,omitempty"`

	// TODO: replace with token
	ActorID *int `json:"actorID,omitempty"`
}

func SendMessageRequest(w http.ResponseWriter, r *http.Request) {
	// get message body
	// start by getting all posts
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)

	// get notification form body
	var message_payload messageBody
	err := json.NewDecoder(r.Body).Decode(&message_payload)

	// check for improper data
	if err != nil {
		http.Error(w, "Incorrect body.", http.StatusBadRequest)
		return
	}

	if message_payload.Message == nil {
		http.Error(w, "Missing message.", http.StatusBadRequest)
		return
	}

	if message_payload.ActorID == nil {
		http.Error(w, "Missing actor.", http.StatusBadRequest)
		return
	}

	if message_payload.PostID == nil {
		http.Error(w, "Missing post.", http.StatusBadRequest)
		return
	}

	// send message

	// create notification
	_, err = dal.NewNotification(db, *message_payload.PostID, *message_payload.ActorID)
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

	// set header and return
	w.WriteHeader(201)
	w.Header().Add("Content-Type", "application/json")
	w.Write([]byte{})
}

func MessageWebSocket(w http.ResponseWriter, r *http.Request) {
	// get message body
	// start by getting all posts
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	upgrader := r.Context().Value(dal.PlatformUpgraderKey{}).(websocket.Upgrader)
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Printf("Failed to upgrade WebSocket connection: %v", err)
		return
	}

	dal.AddConnectionToStore(conn)
	for {
		_, message, err := conn.ReadMessage()
		if err != nil {
			log.Printf("Error reading message: %v", err)
			break
		}

		// Store message in database
		err = dal.SaveMessage(db, string(message))
		if err != nil {
			log.Printf("Failed to save message: %v", err)
			break
		}

		// Broadcast message to all connected clients
		err = dal.BroadcastMessage(string(message), conn)
		if err != nil {
			log.Printf("Broadcast the message: %v", err)
			break
		}
	}

	conn.Close()
}
