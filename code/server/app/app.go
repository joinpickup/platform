package app

import (
	"auth-service/controller"
	"auth-service/dal"
	"database/sql"

	"github.com/go-chi/chi/v5"
	"github.com/joinpickup/middleware-go/logging"
	"github.com/rs/zerolog"
)

func NewRouter(logger zerolog.Logger, db *sql.DB) chi.Router {
	r := chi.NewRouter()

	// middleware
	r.Use(logging.LoggerMiddleware(&logger))
	r.Use(dal.DatabaseMiddleware(db))

	// setup routes
	r.Route("/v1", func(r chi.Router) {
		// health routes
		r.Get("/health", controller.GetHealth)
		r.Get("/healthping", controller.GetPing)

		// post routes
		r.Route("/post", func(r chi.Router) {
			r.Get("/", controller.GetPosts)
			r.Get("/{id}", controller.GetPost)
			r.Put("/{id}", controller.UpdatePost)
			r.Post("/", controller.NewPost)

			// Post Interests
			r.Post("/{id}/interest", controller.AddInterestForPost)

			// TODO: add the following
			// r.Get("/load", controller.LoadMorePosts)
			// r.Get("/search", controller.SearchPosts)
			// r.Get("/filter", controller.FilterPosts)
		})

		r.Route("/person", func(r chi.Router) {
			r.Post("/", controller.NewPerson)
			r.Get("/{id}", controller.GetPerson)

			// person settings
			r.Get("/{id}/setting", controller.GetPersonSettings)
			r.Get("/{id}/setting/{setting_id}", controller.GetPersonSetting)
		})

		r.Route("/notification", func(r chi.Router) {
			r.Post("/", controller.NewNotification)
			r.Get("/{id}", controller.GetNotificationsForUser)
		})

		// actions
		r.Route("/action", func(r chi.Router) {
			r.Put("/message/request", controller.SendMessageRequest)
		})
	})

	return r
}
