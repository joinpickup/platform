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

func GetPerson(db *sql.DB, person_id int) (*model.Person, error) {
	var person model.Person
	var location model.Location

	row := db.QueryRow(
		"SELECT * from get_person($1)",
		person_id,
	)

	err := row.Scan(
		&person.PersonID,
		&person.UserID,
		&person.Name,
		&person.Username,
		&person.Avatar,
		&person.CreatedAt,

		// location
		&location.LocationID,
		&location.CommonName,
		&location.CreatedAt,
	)
	if err != nil {
		return nil, err
	}

	person.Location = &location
	return &person, nil

}
