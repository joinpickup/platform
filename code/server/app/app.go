package app

import (
	"auth-service/controller"

	"github.com/go-chi/chi/v5"
	"github.com/joinpickup/middleware-go/logging"
	"github.com/rs/zerolog"
)

func NewRouter(logger zerolog.Logger) chi.Router {
	r := chi.NewRouter()

	// middleware
	r.Use(logging.LoggerMiddleware(&logger))

	// setup routes
	r.Route("/v1", func(r chi.Router) {
		// health routes
		r.Get("/health", controller.GetHealth)
		r.Get("/healthping", controller.GetPing)

	})

	return r
}
