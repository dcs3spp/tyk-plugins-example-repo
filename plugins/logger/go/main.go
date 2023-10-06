package main

import (
	"net/http"

	"github.com/TykTechnologies/tyk/log"
)

var logger = log.Get()

func PreHook(rw http.ResponseWriter, r *http.Request) {
	logger.Info("Pre request hook is called")
}

func PostKeyAuthHook(rw http.ResponseWriter, r *http.Request) {
	logger.Info("Post key auth hook is called")
}

func PostHook(rw http.ResponseWriter, r *http.Request) {
	logger.Info("Post request hook is called")
}

func AuthCheckHook(rw http.ResponseWriter, r *http.Request) {
	logger.Info("Request auth check is called")
}

func ResponseHook(rw http.ResponseWriter, res *http.Response, r *http.Request) {
	logger.Info("Response hook is called")
	logger.Info("Response hook: upstream returned status code ", res.StatusCode)
}

func init() {
	logger.Info("Plugin bootstrapped")
}

func main() {}
