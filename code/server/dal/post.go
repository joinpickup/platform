package dal

import (
	"auth-service/model"
	"database/sql"
)

func NewPost(
	db *sql.DB,
	title string,
	body string,
	poster_id int,
) (*model.Post, error) {
	var postID int
	var post model.Post
	err := db.QueryRow(
		"SELECT create_post($1, $2, $3)",
		title,
		body,
		poster_id,
	).Scan(&postID)

	if err != nil {
		return nil, err
	}

	post.PostID = postID
	post.Title = title
	post.Body = body

	return &post, nil
}

func GetPostsForUser(db *sql.DB, user_id int) ([]model.Post, error) {
	posts := []model.Post{}

	rows, err := db.Query(
		"SELECT * from get_posts_for_user($1)",
		user_id,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		var post model.Post
		var poster model.Person
		var location model.Location

		rows.Scan(
			&post.PostID,
			&post.CreatedAt,
			&post.Title,
			&post.Body,

			// poster
			&poster.PersonID,
			&poster.UserID,
			&poster.CreatedAt,
			&poster.Name,
			&poster.Username,
			&poster.Avatar,

			// location
			&location.LocationID,
			&location.CommonName,
			&location.CreatedAt,
		)

		interests, err := GetInterestsForPost(db, post.PostID)
		if err != nil {
			return nil, err
		}

		// add generated models
		post.Interests = interests
		poster.Location = &location
		post.Poster = &poster

		posts = append(posts, post)
	}

	return posts, nil
}

func UpdatePost(db *sql.DB, post_id int, body *string) (*model.Post, error) {
	var post model.Post

	row := db.QueryRow(
		"SELECT * from update_post($1, $2)",
		post_id, body,
	)

	err := row.Scan(
		&post.PostID,
		&post.CreatedAt,
		&post.Title,
		&post.Body,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}

		return nil, err
	}

	return &post, nil
}

func AddInterestForPost(db *sql.DB, post_id int, user_id int) error {
	_, err := db.Exec("SELECT add_interest_for_post($1, $2)", post_id, user_id)
	if err != nil {
		// ignore duplicate
		if err.Error() == "pq: duplicate key value violates unique constraint \"post_interest_pkey\"" {
			return nil
		}

		return err
	}
	return nil
}

func GetInterestsForPost(db *sql.DB, post_id int) ([]model.Interest, error) {
	interests := []model.Interest{}
	rows, err := db.Query(
		"SELECT * from get_interests_for_post($1)",
		post_id,
	)

	if err != nil {
		return nil, err
	}

	for rows.Next() {
		var interest model.Interest

		err := rows.Scan(
			&interest.InterestID,
			&interest.Name,
			&interest.Space.Name,
			&interest.Space.SpaceID,
			&interest.CreatedAt,
		)

		if err != nil {
			return nil, err
		}

		interests = append(interests, interest)
	}

	return interests, nil
}

func GetPost(db *sql.DB, post_id int) (*model.Post, error) {
	var post model.Post
	var person model.Person
	var location model.Location

	row := db.QueryRow(
		"SELECT * from get_post($1)",
		post_id,
	)

	err := row.Scan(
		// post
		&post.PostID,
		&post.CreatedAt,
		&post.Title,
		&post.Body,

		// poster
		&person.PersonID,
		&person.UserID,
		&person.CreatedAt,
		&person.Name,
		&person.Username,
		&person.Avatar,

		// location
		&location.LocationID,
		&location.CommonName,
		&location.CreatedAt,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}

		return nil, err
	}

	interests, err := GetInterestsForPost(db, post.PostID)
	if err != nil {
		return nil, err
	}

	// set the generated variables
	person.Location = &location
	post.Poster = &person
	post.Interests = interests

	return &post, nil
}
