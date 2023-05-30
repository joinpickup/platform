package dal

import (
	"context"
	"database/sql"
	"log"
	"net/http"
	"sync"

	"github.com/gorilla/websocket"
)

var (
	Connections = make(map[*websocket.Conn]bool)
	Mutex       sync.Mutex
)

type PlatformUpgraderKey struct{}

func NewUpgrader() websocket.Upgrader {
	return websocket.Upgrader{
		CheckOrigin: func(r *http.Request) bool {
			return true
		},
	}
}

func UpgraderMiddleware(upgrader websocket.Upgrader) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			ctx := context.WithValue(r.Context(), PlatformUpgraderKey{}, upgrader)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

func SaveMessage(db *sql.DB, message string) error {
	return nil
}

func BroadcastMessage(
	message string,
	curr_conn *websocket.Conn,
) error {
	// Retrieve all WebSocket connections
	// Send message to each connection
	Mutex.Lock()
	defer Mutex.Unlock()

	for conn := range Connections {
		if curr_conn != conn {
			err := conn.WriteMessage(websocket.TextMessage, []byte(message))
			if err != nil {
				log.Printf("Error sending message: %v", err)
			}
		}
	}

	return nil
}

func AddConnectionToStore(conn *websocket.Conn) {
	Mutex.Lock()
	Connections[conn] = true
	Mutex.Unlock()
}

func RemoveConnectionFromStore(conn *websocket.Conn) {
	Mutex.Lock()
	delete(Connections, conn)
	Mutex.Unlock()
}
