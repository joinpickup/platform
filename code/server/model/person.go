package model

type Person struct {
	PersonID int `json:"personID,omitempty" db:"person_id"`
	// define fields for Person here
}
