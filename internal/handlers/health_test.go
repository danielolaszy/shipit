package handlers

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
)

// HealthResponse defines the structure of the health check response
type HealthCheckResponseBody struct {
	Status string `json:"status"`
}

func Test_HealthCheck(t *testing.T) {
	// Create a new HTTP request
	req, err := http.NewRequest("GET", "/health", nil)
	assert.NoError(t, err)

	// Create a response recorder
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(HealthCheck)

	// Call the handler with the recorder and the request
	handler.ServeHTTP(rr, req)

	// Assert the status code
	assert.Equal(t, http.StatusOK, rr.Code)

	// Parse the response body
	var response HealthCheckResponseBody
	err = json.Unmarshal(rr.Body.Bytes(), &response)
	assert.NoError(t, err)

	// Assert the response
	assert.Equal(t, "healthy", response.Status)
}
