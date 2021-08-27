package caf_tests

import (
	"log"
	"os"
	"testing"

	"github.com/joho/godotenv"
)

func TestMain(m *testing.M) {
	err := godotenv.Load()
	if err != nil {
		log.Println("No .env file found")
	}
	os.Exit(m.Run())
}
