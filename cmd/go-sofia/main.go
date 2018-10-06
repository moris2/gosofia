package main

import (
  "log"
  "net/http"
)


func main() {
  log.Print("Hello")
  
  err := http.ListenAndServe(":9090", nil)
  if err != nil {
    log.Fatal(err)
  }
  
}