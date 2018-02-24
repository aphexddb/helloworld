package helloworld

import (
	"fmt"
	"log"
	"net/http"
)

// HomeHandler serves up the homepage
func HomeHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "text/html")
	_, err := fmt.Fprintf(w, `<!DOCTYPE html><html lang="en">Hello, world. <a href="/meow">Meow</a>. `)
	if err != nil {
		log.Println(err)
	}
}

// MeowHandler meows.
func MeowHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	_, err := fmt.Fprintf(w, `{"Yes": "Meow!"}`)
	if err != nil {
		log.Println(err)
	}
}
