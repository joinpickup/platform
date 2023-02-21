package main

import (
	"auth-service/app"
	"auth-service/dal"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
	"github.com/joinpickup/middleware-go/logging"
)

func main() {
	env := os.Getenv("ENV")
	if env == "" {
		godotenv.Load()
	}

	logger := logging.NewLogger()
	if os.Getenv("AUTH_DB") == "" {
		logger.Panic().Msg("no env variable for AUTH_DB")
	}

	// setup router and database
	dal.SetupAuthDAL(os.Getenv("AUTH_DB"))
	r := app.NewRouter(logger)

	port := os.Getenv("PORT")
	if port == "" {
		port = "6054"
	}

	// listen on port
	logger.Debug().Msg(fmt.Sprintf("Server running on port: %s\n", port))
	if env != "prod" {
		logger.Debug().Msg("Development Server")
		log.Panic(http.ListenAndServeTLS(fmt.Sprintf(":%s", port), "./ssl/joinpickup-dev.cer.pem", "./ssl/joinpickup-dev.key.pem", r))
	} else {
		logger.Debug().Msg("Production Server")
		log.Panic(http.ListenAndServeTLS(fmt.Sprintf(":%s", port), "./ssl/joinpickup-dev.cer.pem", "./ssl/joinpickup-dev.key.pem", r))
		log.Panic(http.ListenAndServe(fmt.Sprintf(":%s", port), r))
	}

	defer dal.AuthDAL.Close()
}
