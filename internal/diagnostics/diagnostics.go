package diagnostics

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func NewDiagnostics() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/healthz", healthz)
	router.HandleFunc("/readyz", readyz)
	return router
}

func healthz(w http.ResponseWriter, r *http.Request) {
	log.Print("The healthz handler was called")
	fmt.Fprint(w, http.StatusText(http.StatusOK))
}

func readyz(w http.ResponseWriter, r *http.Request) {
	log.Print("The ready handler was called")
	fmt.Fprint(w, http.StatusText(http.StatusOK))
}
