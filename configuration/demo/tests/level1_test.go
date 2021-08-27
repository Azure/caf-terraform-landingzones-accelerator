// +build level1

package caf_tests

import (
	"testing"

	"github.com/aztfmod/terratest-helper-caf/state"
	"github.com/stretchr/testify/assert"
)

func TestFoundationsLandingZoneKey(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "foundations")

	landingZoneKey := tfState.GetLandingZoneKey()
	assert.Equal(t, "foundations", landingZoneKey)
}

func TestFoundationClientConfigSubscriptionId(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "foundations")

	client_config := tfState.GetClientConfig()
	assert.Equal(t, tfState.SubscriptionID, client_config["subscription_id"].(string))
}

func TestFoundationGlobalSettingsEnvironment(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "foundations")

	global_settings := tfState.GetGlobalSettings()
	assert.Equal(t, tfState.Environment, global_settings["environment"].(string))
}
