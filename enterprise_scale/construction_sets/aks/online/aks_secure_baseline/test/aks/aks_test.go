package aks

import (
	"secureaks/tests/util"
	"testing"

	"github.com/Azure/azure-sdk-for-go/services/containerservice/mgmt/2019-11-01/containerservice"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

type ExpectedValues struct {
	ClusterName            string
	ResourceGroupName      string
	DefaultNodePoolName    string
	UserNodepoolName       string
	AgentCount             int
	OMSAgentEnabled        bool
	AzurePolicyEnabled     bool
	NetworkPlugin          string
	ManagedOutboundIpCount int
	RBACEnabled            bool
	NetworkPolicy          string
	KeyVaultName           string
}

func TestAksAgentPoolProfile(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	cluster := getCluster(t, expectedValues.ResourceGroupName, expectedValues.ClusterName)

	// Test that the Nodepool name matches the Terraform specification
	assert.Equal(t, expectedValues.DefaultNodePoolName, string(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[1].Name), "Default node pool didn't not match")
	assert.Equal(t, expectedValues.UserNodepoolName, string(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[0].Name), "User node pool didn't match")

	// Test that the Node count matches the Terraform specification
	assert.Equal(t, expectedValues.AgentCount, int(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[0].Count))
	assert.Equal(t, expectedValues.AgentCount, int(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[1].Count))
}

func TestAksAddOnProfile(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	cluster := getCluster(t, expectedValues.ResourceGroupName, expectedValues.ClusterName)

	// Test if OMS agent is enabled
	assert.Equal(t, expectedValues.OMSAgentEnabled, *(cluster.ManagedClusterProperties.AddonProfiles["omsagent"].Enabled))

	// Test if Azure policy is enabled
	assert.Equal(t, expectedValues.AzurePolicyEnabled, *(cluster.ManagedClusterProperties.AddonProfiles["azurepolicy"].Enabled))
}

func TestAksLoadBalancerProfile(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	cluster := getCluster(t, expectedValues.ResourceGroupName, expectedValues.ClusterName)

	// Test Network type (plugin)
	assert.Equal(t, expectedValues.NetworkPlugin, string(cluster.NetworkProfile.NetworkPlugin))

	// Test Network policy
	// assert.Equal(t, expectedValues.NetworkPolicy, string(cluster.NetworkProfile.NetworkPolicy))
}

func TestAksNetworkProfile(t *testing.T) {
	t.Parallel()

	//Looks like there is a new bug in AKS API
	//It returns empty NetworkProfile.LoadBalancerProfile
	//commenting it out for now

	// 	expectedValues := getExpectedValues()

	// 	cluster := getCluster(t, expectedValues.ResourceGroupName, expectedValues.ClusterName)
	// 	managedOutboundIpCount := 0

	// Test loadbalancer managed outbound IP count
	// 	if cluster.ManagedClusterProperties.NetworkProfile.LoadBalancerProfile != nil {
	// 		managedOutboundIpCount = int(*(*&cluster.ManagedClusterProperties.NetworkProfile.LoadBalancerProfile.ManagedOutboundIPs.Count))
	// 	}

	//assert.Equal(t, expectedValues.ManagedOutboundIpCount, managedOutboundIpCount)
}

func TestAksRbacEnbaled(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	cluster := getCluster(t, expectedValues.ResourceGroupName, expectedValues.ClusterName)

	// Test cluster is RBAC enabled
	assert.Equal(t, expectedValues.RBACEnabled, *(cluster.ManagedClusterProperties.EnableRBAC))

}

func TestAKSManagedAad(t *testing.T) {
	t.Parallel()
	expectedValues := getExpectedValues()

	cluster := getCluster(t, expectedValues.ResourceGroupName, expectedValues.ClusterName)

	// Test AKS-managed Azure Active Directory is  enabled
	assert.NotEmpty(t, *(cluster.ManagedClusterProperties.AadProfile))

}

func getCluster(t *testing.T, expectedResourceGroupName, expectedClusterName string) *containerservice.ManagedCluster {
	cluster, err := azure.GetManagedClusterE(t, util.ResolveNameWithPrefix(expectedResourceGroupName), util.ResolveNameWithPrefix(expectedClusterName), "")
	require.NoError(t, err)

	return cluster
}

func TestKeyVault(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	keyVaultName := util.ResolveNameWithPrefix(expectedValues.KeyVaultName)
	resourceGroupName := util.ResolveNameWithPrefix(expectedValues.ResourceGroupName)

	// Test key vault exists
	keyVault := azure.GetKeyVault(t, resourceGroupName, keyVaultName, "")
	assert.Equal(t, keyVaultName, *keyVault.Name)
}

func getExpectedValues() ExpectedValues {
	var expectedValues ExpectedValues
	util.ReadTestConfig("ExpectedValues", &expectedValues)
	return expectedValues
}
