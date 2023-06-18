package controller

import (
	"auth-service/dal"
	"database/sql"
	"encoding/json"
	"net/http"
)

func GetAllIntersts(w http.ResponseWriter, r *http.Request) {
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	interests, err := dal.GetAllIntersts(db)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	posts_str, err := json.Marshal(interests)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write(posts_str)
}
