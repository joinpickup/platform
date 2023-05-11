package dal

import (
	"auth-service/model"
	"database/sql"
)

func NewPost(db *sql.DB, post model.Post) (*model.Post, error) {
	var postID int
	err := db.QueryRow(
		"SELECT create_post($1, $2, $3)",
		post.Title,
		post.Body,
		post.PosterID,
	).Scan(&postID)

	if err != nil {
		return nil, err
	}

	post.PostID = postID
	return &post, nil
}
