package controller

import (
	"auth-service/dal"
	"auth-service/model"
	"database/sql"
	"encoding/json"
	"net/http"
)

func NewPerson(w http.ResponseWriter, r *http.Request) {
	// start by getting all posts
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	newPerson, err := dal.NewPerson(db, model.Person{})

	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	newPersonRes, err := json.Marshal(newPerson)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write(newPersonRes)
}
