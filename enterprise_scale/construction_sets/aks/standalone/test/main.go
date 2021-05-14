package main

import (
	"testing"

	"util"
)

type Configurations struct {
	imname string
	rgname string
}

func TestManagedIdentity(t *testing.T) {
	t.Parallel()
	//TODO: Once Terrtest helper for Azure managed identity is developed, add tests for Azure managed identity.

}

func getTestConfig() Configurations {
	var configuration Configurations
	util.ReadTestConfig("config.yaml", configuration)
	// var test1 = util.Test
	return configuration
}
