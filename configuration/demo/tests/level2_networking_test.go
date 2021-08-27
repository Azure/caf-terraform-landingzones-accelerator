// +build level2,networking

package caf_tests

import (
	"context"
	"fmt"
	"log"
	"strings"
	"testing"

	"github.com/aztfmod/terratest-helper-caf/state"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/Azure/azure-sdk-for-go/sdk/arm/resources/2020-06-01/armresources"
	"github.com/Azure/azure-sdk-for-go/sdk/armcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
)

func TestThereAreTwoResourceGroupsForNetworkingHub(t *testing.T) {
	t.Parallel()

	tfState := state.NewTerraformState(t, "networking_hub")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		name := resourceGroup.GetName()
		actual_rc := azure.GetAResourceGroup(t, name, tfState.SubscriptionID)

		//assert.Equal(t, *actual_rc.Tags["landingzone"], tfState.GetLandingZoneKey())
		assert.Equal(t, *actual_rc.Tags["environment"], tfState.Environment)
		assert.Equal(t, *actual_rc.Tags["level"], resourceGroup.GetLevel())
	}
}


func TestVirtualNetworksAreInDifferentRegions(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "networking_hub")
	vNets := tfState.GetVNets()

	var locations []string
	for _, vnet := range vNets {
		vn, err := azure.GetVirtualNetworkE(vnet.GetName(), vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		locations = append(locations, *vn.Location)
	}

	assert.NotEqual(t, locations[0], locations[1], fmt.Sprintf("Virtual Networks in the 'landingzone=%s' resource groups should provisioned in different regions", tfState.GetLandingZoneKey()))
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

func TestBastionSubNetSecurityRulesCount(t *testing.T) {
	t.Parallel()

	tfState := state.NewTerraformState(t, "networking_hub")
	vNets := tfState.GetVNets()

	for _, vnet := range vNets {
		resources, err := ListResourcesNamesInResourceGroupE(vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		for _, res := range resources {
			if strings.HasPrefix(res, fmt.Sprintf("%s-nsg-AzureBastionSubnet", strings.Split(vnet.GetString("resource_group_name"), "-rg")[0])) {
				rules := azure.GetAllNSGRules(t, vnet.GetString("resource_group_name"), res, tfState.SubscriptionID)
				assert.Equal(t, 12, len(rules.SummarizedRules), fmt.Sprintf("Bastion Subnet should have 12 rules, found %d", len(rules.SummarizedRules)))
			}
		}
	}
}

func TestBastionSubNetInboundSecurityRules(t *testing.T) {
	t.Parallel()
	expected_port_rage := []string{"*", "*", "*", "4443", "443", "135"}

	tfState := state.NewTerraformState(t, "networking_hub")
	vNets := tfState.GetVNets()

	for _, vnet := range vNets {
		resources, err := ListResourcesNamesInResourceGroupE(vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		for _, res := range resources {
			if strings.HasPrefix(res, fmt.Sprintf("%s-nsg-AzureBastionSubnet", strings.Split(vnet.GetString("resource_group_name"), "-rg")[0])) {
				rules := azure.GetAllNSGRules(t, vnet.GetString("resource_group_name"), res, tfState.SubscriptionID)
				var actual_port_rage []string

				for _, rule := range rules.SummarizedRules {
					if rule.Direction == "Inbound" {
						actual_port_rage = append(actual_port_rage, rule.DestinationPortRange)
					}
				}

				assert.ElementsMatch(t, expected_port_rage, actual_port_rage, fmt.Sprintf("Bastion Subnet doesn't have expected destination ports: %+q", expected_port_rage))
			}
		}
	}
}

func TestBastionSubNetOutboundSecurityRules(t *testing.T) {
	t.Parallel()

	expected_port_rage := []string{"*", "*", "*", "443", "3389", "22"}

	tfState := state.NewTerraformState(t, "networking_hub")
	vNets := tfState.GetVNets()

	for _, vnet := range vNets {
		resources, err := ListResourcesNamesInResourceGroupE(vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		for _, res := range resources {
			if strings.HasPrefix(res, fmt.Sprintf("%s-nsg-AzureBastionSubnet", strings.Split(vnet.GetString("resource_group_name"), "-rg")[0])) {
				rules := azure.GetAllNSGRules(t, vnet.GetString("resource_group_name"), res, tfState.SubscriptionID)
				var actual_port_rage []string

				for _, rule := range rules.SummarizedRules {
					if rule.Direction == "Outbound" {
						actual_port_rage = append(actual_port_rage, rule.DestinationPortRange)
					}
				}

				assert.ElementsMatch(t, expected_port_rage, actual_port_rage, fmt.Sprintf("Bastion Subnet doesn't have expected destination ports: %+q", expected_port_rage))
			}
		}
	}
}

func TestJumpboxSecurityRulesCount(t *testing.T) {
	t.Parallel()

	tfState := state.NewTerraformState(t, "networking_hub")
	vNets := tfState.GetVNets()

	for _, vnet := range vNets {
		resources, err := ListResourcesNamesInResourceGroupE(vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		for _, res := range resources {
			if strings.HasPrefix(res, fmt.Sprintf("%s-nsg-jumpbox", strings.Split(vnet.GetString("resource_group_name"), "-rg")[0])) {
				rules := azure.GetAllNSGRules(t, vnet.GetString("resource_group_name"), res, tfState.SubscriptionID)
				assert.Equal(t, 7, len(rules.SummarizedRules), fmt.Sprintf("Jumpbox Subnet should have 7 rules, found %d", len(rules.SummarizedRules)))
			}
		}
	}
}

func TestJumpboxInboundSecurityRules(t *testing.T) {
	t.Parallel()

	expected_port_rage := []string{"*", "*", "*", "22"}

	tfState := state.NewTerraformState(t, "networking_hub")
	vNets := tfState.GetVNets()

	for _, vnet := range vNets {
		resources, err := ListResourcesNamesInResourceGroupE(vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		for _, res := range resources {
			if strings.HasPrefix(res, fmt.Sprintf("%s-nsg-jumpbox", strings.Split(vnet.GetString("resource_group_name"), "-rg")[0])) {
				rules := azure.GetAllNSGRules(t, vnet.GetString("resource_group_name"), res, tfState.SubscriptionID)

				var actual_port_rage []string

				for _, rule := range rules.SummarizedRules {
					if rule.Direction == "Inbound" {
						actual_port_rage = append(actual_port_rage, rule.DestinationPortRange)
					}
				}

				assert.ElementsMatch(t, expected_port_rage, actual_port_rage, fmt.Sprintf("Jumpbox Subnet doesn't have expected destination ports: %+q", expected_port_rage))
			}
		}
	}
}

func TestJumpboxOutboundSecurityRules(t *testing.T) {
	t.Parallel()

	expected_port_rage := []string{"*", "*", "*"}

	tfState := state.NewTerraformState(t, "networking_hub")
	vNets := tfState.GetVNets()

	for _, vnet := range vNets {
		resources, err := ListResourcesNamesInResourceGroupE(vnet.GetString("resource_group_name"), tfState.SubscriptionID)
		require.NoError(t, err)

		for _, res := range resources {
			if strings.HasPrefix(res, fmt.Sprintf("%s-nsg-jumpbox", strings.Split(vnet.GetString("resource_group_name"), "-rg")[0])) {
				rules := azure.GetAllNSGRules(t, vnet.GetString("resource_group_name"), res, tfState.SubscriptionID)

				var actual_port_rage []string

				for _, rule := range rules.SummarizedRules {
					if rule.Direction == "Outbound" {
						actual_port_rage = append(actual_port_rage, rule.DestinationPortRange)
					}
				}

				assert.ElementsMatch(t, expected_port_rage, actual_port_rage, fmt.Sprintf("Jumpbox Subnet doesn't have expected destination ports: %+q", expected_port_rage))
			}
		}
	}
}