// +build level3,amlworkspace

package caf_tests

import (
	"fmt"
	"testing"
	"strings"
	"log"
	"context"

	"github.com/aztfmod/terratest-helper-caf/state"
	"github.com/stretchr/testify/assert"

	"github.com/stretchr/testify/require"

	"github.com/gruntwork-io/terratest/modules/azure"

	"github.com/Azure/azure-sdk-for-go/sdk/arm/resources/2020-06-01/armresources"
	"github.com/Azure/azure-sdk-for-go/sdk/armcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
)

func TestAMLWorkspaceLandingZoneKey(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "101-aml-workspace")

	landingZoneKey := tfState.GetLandingZoneKey()
	assert.Equal(t, "101-aml-workspace", landingZoneKey)
}

func TestAMLWorkspaceResourceGroupIsExists(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "101-aml-workspace")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		name := resourceGroup.GetName()
		exists := azure.ResourceGroupExists(t, name, tfState.SubscriptionID)
		assert.True(t, exists, fmt.Sprintf("Resource group (%s) does not exist", name))
	}
}

func TestAMLWorkspaceResourceGroupHasStorageAccount(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "101-aml-workspace")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		storageAccount, err := tfState.GetStorageAccountByResourceGroup(rgName)
		if err != nil {
			panic(err)
		}
		storageAccountName := storageAccount.GetName()
		storageAccountExists := azure.StorageAccountExists(t, storageAccountName, rgName, tfState.SubscriptionID)
		assert.True(t, storageAccountExists, "storage account does not exist")
	}
}

func TestAMLWorkspaceResourceGroupHasKeyVault(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "101-aml-workspace")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		keyVault, err := tfState.GetKeyVaultByResourceGroup(rgName)
		if err != nil {
			panic(err)
		}
		keyVaultName := keyVault.GetName()
		kv := azure.GetKeyVault(t, rgName, keyVaultName, tfState.SubscriptionID)
		assert.NotNil(t, kv, fmt.Sprintf("KeyVault (%s) does not exists", keyVaultName))
	}
}

func TestAMLWorkspaceResourceGroupHasAppInsights(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "101-aml-workspace")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		appInsights := tfState.GetAppInsights()

		for _, appInsight := range appInsights {
			appInsightsID := appInsight.GetID()
			idSplit := strings.Split(appInsightsID, "/")
			appInsightsName := idSplit[len(idSplit)-1]

			resources, resourceErr := ListResourcesNamesInResourceGroupE(rgName, tfState.SubscriptionID)
			require.NoError(t, resourceErr)

			isFound := contains(resources,appInsightsName)
			assert.True(t, isFound, fmt.Sprintf("App Insights (%s) does not exists", appInsightsName))
		}
	}
}

func TestAMLWorkspaceResourceGroupHasMachineLearningWorkspaces(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "101-aml-workspace")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		machineLearningWorkspaces := tfState.GetMachineLearningWorkspaces()

		for _, machineLearningWorkspace := range machineLearningWorkspaces {
			machineLearningWorkspaceName := machineLearningWorkspace.GetName()

			resources, resourceErr := ListResourcesNamesInResourceGroupE(rgName, tfState.SubscriptionID)
			require.NoError(t, resourceErr)

			isFound := contains(resources,machineLearningWorkspaceName)
			assert.True(t, isFound, fmt.Sprintf("Machine Learning Workspace (%s) does not exists", machineLearningWorkspaceName))
		}
	}
}


func contains(arr []string, str string) bool {
	for _, a := range arr {
		 if a == str {
				return true
		 }
	}
	return false
}

func ListResourcesNamesInResourceGroupE(rgName, SubscriptionID string) ([]string, error) {
	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		log.Fatalf("failed to obtain a credential: %v", err)
	}
	client := armresources.NewResourcesClient(armcore.NewDefaultConnection(cred, nil), SubscriptionID)
	//client := armresources.NewResourcesClient(armcore.NewConnection("usgovernment", cred, nil), SubscriptionID)
	page := client.ListByResourceGroup(rgName, nil)

	resources := []string{}
	for page.NextPage(context.Background()) {
		resp := page.PageResponse()

		if len(*resp.ResourceListResult.Value) != 0 {
			for _, val := range *resp.ResourceListResult.Value {
				resources = append(resources, *val.Name)
			}
		}
	}
	if err := page.Err(); err != nil {
		log.Fatal(err)
		return nil, err
	}
	return resources, nil

}