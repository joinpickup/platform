package model

import "time"

type Interest struct {
	InterestID int        `json:"interestID,omitempty" db:"interest_id"`
	Name       string     `json:"name,omitempty" db:"name"`
	Space      Space      `json:"space,omitempty" db:"-"`
	CreatedAt  *time.Time `json:"createdAt,omitempty" db:"created_at"`
	// define fields for Interest here
}
