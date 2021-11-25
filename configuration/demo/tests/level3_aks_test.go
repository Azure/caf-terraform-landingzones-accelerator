// +build level3,aks

package caf_tests

import (
	"fmt"
	"log"
	"context"
	"testing"

	"github.com/aztfmod/terratest-helper-caf/state"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/gruntwork-io/terratest/modules/azure"
	
	"github.com/Azure/azure-sdk-for-go/sdk/arm/resources/2020-06-01/armresources"
	"github.com/Azure/azure-sdk-for-go/sdk/armcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
)

func TestAKSLandingZoneKey(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "cluster_aks")

	landingZoneKey := tfState.GetLandingZoneKey()
	assert.Equal(t, "cluster_aks", landingZoneKey)
}

func TestAKSResourceGroupIsExists(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "cluster_aks")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		name := resourceGroup.GetName()
		exists := azure.ResourceGroupExists(t, name, tfState.SubscriptionID)
		assert.True(t, exists, fmt.Sprintf("Resource group (%s) does not exist", name))
	}
}

func TestAKSVirtualNetworksIsExists(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "cluster_aks")
	vNets := tfState.GetVNets()

	for _, vnet := range vNets {
		vn, err := azure.GetVirtualNetworkE(vnet.GetName(), vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		assert.NotNil(t, vn, fmt.Sprintf("VNET (%s) does not exists", vnet.GetName()))
	}
}

func TestAKSClustersIsExists(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "cluster_aks")
	aksClusters := tfState.GetAKSClusters()
	
	for _, cluster := range aksClusters {
		resources, resourceErr := ListResourcesNamesInResourceGroupE(cluster.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, resourceErr)
			isFound := contains(resources,cluster.GetString("cluster_name"))
			assert.True(t, isFound, fmt.Sprintf("AKSCluster (%s) does not exists", cluster.GetString("cluster_name")))
	}
}

func TestAzureContainerRegistriesIsExists(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "cluster_aks")
	acrs := tfState.GetAzureContainerRegistries()
	
	for _, acr := range acrs {
		resources, resourceErr := ListResourcesNamesInResourceGroupE(acr.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, resourceErr)
			isFound := contains(resources,acr.GetString("name"))
			assert.True(t, isFound, fmt.Sprintf("Azure Container Registry (%s) does not exists", acr.GetString("name")))
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
