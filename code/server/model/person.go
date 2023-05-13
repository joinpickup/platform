package model

import "time"

type Person struct {
	PersonID  int        `json:"personID,omitempty" db:"person_id"`
	UserID    int        `json:"userID,omitempty" db:"user_id"`
	Name      string     `json:"name,omitempty" db:"name"`
	Username  string     `json:"username,omitempty" db:"username"`
	Avatar    string     `json:"avatar,omitempty" db:"avatar"`
	Location  *Location  `json:"location,omitempty" db:"location"`
	CreatedAt *time.Time `json:"createdAt,omitempty" db:"created_at"`
}
