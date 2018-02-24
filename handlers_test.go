package helloworld

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
)

// TestMeowHandler tests MeowHandler
func TestMeowHandler(t *testing.T) {
	req, err := http.NewRequest("GET", "/meow", nil)
	if err != nil {
		t.Fatal(err)
	}

	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(MeowHandler)
	handler.ServeHTTP(rr, req)

	assert.Equal(t, http.StatusOK, rr.Code)
	assert.Equal(t, `{"Yes": "Meow!"}`, rr.Body.String())
}
