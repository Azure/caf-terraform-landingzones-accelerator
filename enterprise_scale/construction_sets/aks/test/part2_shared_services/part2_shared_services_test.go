package sharedservices

import (
	"secureaks/tests/util"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
)

type ExpectedValues struct {
	LogWorkspaceName     string
	LogResourceGroupName string
}

func TestLogAnalytics(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	workSpaceName := util.ResolveNameWithPrefix(expectedValues.LogWorkspaceName)
	resourceGroupName := util.ResolveNameWithPrefix(expectedValues.LogResourceGroupName)

	workspaceExists := azure.LogAnalyticsWorkspaceExists(t, workSpaceName, resourceGroupName, "")
	assert.True(t, workspaceExists, "log analytics workspace not found.")
}

func getExpectedValues() ExpectedValues {
	var expectedValues ExpectedValues
	util.ReadTestConfig("ExpectedValues", &expectedValues)
	return expectedValues
}
