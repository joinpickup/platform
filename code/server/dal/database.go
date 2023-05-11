package dal

import (
	"context"
	"database/sql"
	"net/http"

	"github.com/joinpickup/middleware-go/database"
)

type PlatformDBKey struct{}

func NewPlatformDB(connStr string) (*sql.DB, error) {
	return database.NewDatabase(connStr)
}

func DatabaseMiddleware(db *sql.DB) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			ctx := context.WithValue(r.Context(), PlatformDBKey{}, db)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}
