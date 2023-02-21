package controller

import (
	"auth-service/dal"
	"encoding/json"
	"net/http"
	"os"

	"github.com/joinpickup/middleware-go/models"
	"github.com/joinpickup/middleware-go/support"
)

func GetHealth(w http.ResponseWriter, r *http.Request) {
	health := models.Health{
		Status:  "online",
		Version: support.TrimQuotes(os.Getenv("VERSION")),
		Tests:   []models.HealthTest{},
	}

	// setup health tests
	// check database connection
	var databaseTest models.HealthTest

	// try to connect
	err := dal.AuthDAL.Ping()

	if err != nil {
		databaseTest = models.HealthTest{
			Name:    "Failed to connect to the auth database",
			Status:  "failed",
			Message: err.Error(),
		}
		health.Status = "failed"
	} else {
		databaseTest = models.HealthTest{
			Name:    "Can connect to the auth database",
			Status:  "success",
			Message: "",
		}
	}

	health.Tests = append(health.Tests, databaseTest)

	healthJS, _ := json.Marshal(health)

	// set header and return
	w.Header().Add("Content-Type", "application/json")
	w.Write(healthJS)
}

func GetPing(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("pong"))
}
