package dal

import (
	"database/sql"

	"github.com/joinpickup/middleware-go/database"
)

var (
	AuthDAL *sql.DB
)

func SetupAuthDAL(connStr string) error {
	db, err := database.NewDatabase(connStr)
	if err != nil {
		return err
	}

	AuthDAL = db
	return nil
}
