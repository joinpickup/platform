package controller

import (
	"auth-service/dal"
	"auth-service/model"
	"database/sql"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
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

func GetPerson(w http.ResponseWriter, r *http.Request) {
	// serialize the id from the query params
	id := chi.URLParam(r, "id")
	person_id, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		http.Error(w, "Invalid ID.", http.StatusBadRequest)
		return
	}

	// get the DB from the context
	db := r.Context().Value(dal.PlatformDBKey{}).(*sql.DB)
	person, err := dal.GetPerson(db, int(person_id))
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// marshal the person to return to the caller
	person_marsh, err := json.Marshal(person)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// return back the item
	w.WriteHeader(200)
	w.Header().Add("Content-Type", "application/json")
	w.Write(person_marsh)
}

func GetPersonSetting(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "application/json")
	w.Write([]byte{})
}

func GetPersonSettings(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "application/json")
	w.Write([]byte{})
}
