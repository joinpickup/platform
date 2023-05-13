package model

type Space struct {
	SpaceID     int    `json:"spaceID,omitempty" db:"space_id"`
	Name        string `json:"name,omitempty" db:"name"`
	Description string `json:"description,omitempty" db:"description"`
	// define fields for Interest here
}
