package model

import "time"

type Notification struct {
	NotificationID int        `db:"notification_id" json:"notificationID,omitempty"`
	CreatedAt      *time.Time `db:"created_at" json:"createdAt,omitempty"`
	PostID         int        `db:"post_id" json:"postID,omitempty"`
	Post           *Post      `json:"post,omitempty"`
	IsRead         bool       `db:"is_read" json:"isRead,omitempty"`
	ActorID        int        `db:"actor_id" json:"actorID,omitempty"`
	Actor          *Person    `json:"actor,omitempty"`
}
