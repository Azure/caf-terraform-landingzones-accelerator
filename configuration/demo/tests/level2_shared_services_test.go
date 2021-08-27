// +build level2,sharedsvc

package caf_tests

import (
	"testing"

	"github.com/aztfmod/terratest-helper-caf/state"
	"github.com/stretchr/testify/assert"
)

func TestSharedServicesLandingZoneKey(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "shared_services")

	landingZoneKey := tfState.GetLandingZoneKey()
	assert.Equal(t, "shared_services", landingZoneKey)
}
