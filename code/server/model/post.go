package model

import "time"

type Post struct {
	PostID    int        `json:"postID,omitempty" db:"post_id"`
	CreatedAt time.Time  `json:"createdAt" db:"created_at"`
	Title     string     `json:"title" db:"title"`
	Body      string     `json:"body" db:"body"`
	PosterID  int        `json:"posterID" db:"post_id"`
	Poster    Person     `json:"poster" db:"-"`
	Interests []Interest `json:"interests" db:"-"`
}
