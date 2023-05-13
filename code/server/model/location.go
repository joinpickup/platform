package model

import "time"

type Location struct {
	LocationID  int        `json:"locationID,omitempty" db:"location_id"`
	CommonName  string     `json:"commonName,omitempty" db:"common_name"`
	Description string     `json:"description,omitempty" db:"description"`
	CreatedAt   *time.Time `json:"createdAt,omitempty" db:"created_at"`
}
