package main

import (
	"log"
	"net/http"
	"time"

	"github.com/aphexddb/helloworld"
	"github.com/gorilla/mux"
)

func main() {
	log.Println("starting helloworld")

	r := mux.NewRouter()
	r.HandleFunc("/", helloworld.HomeHandler)
	r.HandleFunc("/meow", helloworld.MeowHandler)

	srv := &http.Server{
		Handler: r,
		Addr:    "0.0.0.0:8080",
		// Good practice: enforce timeouts for servers you create!
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(srv.ListenAndServe())

}
