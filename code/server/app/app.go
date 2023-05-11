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
			r.Post("/", controller.NewPost)
		})

		r.Route("/person", func(r chi.Router) {
			r.Post("/", controller.NewPerson)
		})
	})

	return r
}
