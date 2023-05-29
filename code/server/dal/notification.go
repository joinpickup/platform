package dal

import (
	"auth-service/model"
	"database/sql"
)

func GetNotifications(
	db *sql.DB,
	person_id int,
	is_read bool,
) ([]model.Notification, error) {
	var notifications []model.Notification

	rows, err := db.Query(
		"SELECT * from get_notifications_for_person($1, $2)",
		person_id,
		is_read,
	)
	if err != nil {
		return nil, err
	}

	for rows.Next() {
		// get all of the models for the notification
		var notification model.Notification

		var post model.Post

		var actor model.Person
		var actor_location model.Location

		var poster model.Person
		var poster_location model.Location

		err := rows.Scan(
			&notification.NotificationID,
			&notification.CreatedAt,
			&notification.IsRead,

			// get post data
			&post.PostID,
			&post.CreatedAt,
			&post.Title,
			&post.Body,

			// get actor data
			&poster.PersonID,
			&poster.UserID,
			&poster.Name,
			&poster.Username,
			&poster.Avatar,
			&poster.CreatedAt,

			// location
			&poster_location.LocationID,
			&poster_location.CommonName,
			&poster_location.CreatedAt,

			// get actor data
			&actor.PersonID,
			&actor.UserID,
			&actor.Name,
			&actor.Username,
			&actor.Avatar,
			&actor.CreatedAt,

			// location
			&actor_location.LocationID,
			&actor_location.CommonName,
			&actor_location.CreatedAt,
		)
		if err != nil {
			if err == sql.ErrNoRows {
				return nil, nil
			}

			return nil, err
		}

		// set the generated variables
		actor.Location = &actor_location
		poster.Location = &poster_location
		post.Poster = &poster

		notification.Post = &post
		notification.Actor = &actor

		notifications = append(notifications, notification)
	}

	return notifications, nil
}

func NewNotification(
	db *sql.DB,
	post_id int,
	actor_id int,
) (*model.Notification, error) {
	var notification model.Notification
	var notification_id int

	err := db.QueryRow(
		"SELECT create_notification($1, $2)",
		post_id,
		actor_id,
	).Scan(&notification_id)

	if err != nil {
		return nil, err
	}

	notification.NotificationID = notification_id
	return &notification, nil
}
