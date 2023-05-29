package model

import "time"

type Post struct {
	PostID    int        `json:"postID,omitempty" db:"post_id"`
	CreatedAt *time.Time `json:"createdAt,omitempty" db:"created_at"`
	Title     string     `json:"title,omitempty" db:"title"`
	Body      string     `json:"body,omitempty" db:"body"`
	Poster    *Person    `json:"poster,omitempty" db:"-"`
	Interests []Interest `json:"interests" db:"-"`
}
