package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
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

func main() {
	log.Println("starting helloworld")

	r := mux.NewRouter()
	r.HandleFunc("/", HomeHandler)
	r.HandleFunc("/meow", MeowHandler)

	srv := &http.Server{
		Handler: r,
		Addr:    "0.0.0.0:8080",
		// Good practice: enforce timeouts for servers you create!
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())

}
