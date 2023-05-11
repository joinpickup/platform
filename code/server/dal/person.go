package dal

import (
	"auth-service/model"
	"database/sql"
)

func NewPerson(db *sql.DB, person model.Person) (*model.Person, error) {
	var personID int
	err := db.QueryRow(
		"SELECT create_person()",
	).Scan(&personID)

	if err != nil {
		return nil, err
	}

	person.PersonID = personID
	return &person, nil
}
