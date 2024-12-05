package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/danielolaszy/ShipIt/internal/handlers"
)

func main() {
	// Register the health check endpoint with the HTTP server.
	// When a client accesses "/health", the HealthCheck handler is executed.
	http.HandleFunc("/health", handlers.HealthCheck)

	// Define the port number on which the server will listen for incoming requests.
	port := 8080

	// Log a message indicating that the server has started and is running.
	log.Printf("Server is running on :%d", port)

	// Start the HTTP server and bind it to the specified port.
	// The second argument (nil) means the default HTTP mux (multiplexer) will be used.
	err := http.ListenAndServe(fmt.Sprintf(":%d", port), nil)

	// If the server fails to start, log the error and terminate the program.
	if err != nil {
		log.Fatal(err)
	}
}
