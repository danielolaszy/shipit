package handlers

import (
	"encoding/json"
	"log"
	"net/http"
)

// HealthCheck handles health check requests
func HealthCheck(w http.ResponseWriter, r *http.Request) {
	// Log every hit to the /health endpoint
	log.Printf("Health endpoint hit: method=%s, path=%s, remote_addr=%s", r.Method, r.URL.Path, r.RemoteAddr)

	// Create a response payload as a map with a "status" key set to "healthy".
	// This indicates that the application is functioning correctly.
	response := map[string]string{"status": "healthy"}

	// Set the "Content-Type" header to "application/json".
	// This informs the client that the response is in JSON format.
	w.Header().Set("Content-Type", "application/json")

	// Set the HTTP status code to 200 OK, indicating the request was successful.
	w.WriteHeader(http.StatusOK)

	// Encode the response map as JSON and write it to the response writer.
	// This sends the JSON response back to the client.
	err := json.NewEncoder(w).Encode(response)
	if err != nil {
		// Log an error if JSON encoding fails
		http.Error(w, "Failed to encode response", http.StatusInternalServerError)
	}
}
