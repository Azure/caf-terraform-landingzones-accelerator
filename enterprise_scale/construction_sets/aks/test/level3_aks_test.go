package aks

import (
	"fmt"
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestAksAgentPoolProfile(t *testing.T) {
	t.Parallel()

	// Declare expected values for assertions
	expectedClusterName := fmt.Sprintf("%s-aks-akscluster-re1-001", os.Getenv("PREFIX"))
	expectedResourceGroupName := fmt.Sprintf("%s-rg-aks-re1", os.Getenv("PREFIX"))
	expectedDefaultNodePoolName := "sharedsvc"
	expectedUserNodepoolName := "npuser01"
	expectedAgentCount := 3

	// Alternative way of reading Terraform Variables directly from .tfvars
	// aksVarFile, err := filepath.Abs(string("../online/aks_secure_baseline/configuration/aks.tfvars"))
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// var aksVars map[string]interface{}
	// error := terraform.GetAllVariablesFromVarFileE(t, aksVarFile, &aksVars)
	// require.NoError(t, error)
	// fmt.Println(aksVars["aks_clusters"].(map[string]interface{})["cluster_re1"].(map[string]interface{})["default_node_pool"].(map[string]interface{})["name"])
	// defaultNodePoolName := (aksVars["aks_clusters"].(map[string]interface{})["cluster_re1"].(map[string]interface{})["default_node_pool"].(map[string]interface{})["name"].(string))

	// Get manged cluster client
	cluster, err := azure.GetManagedClusterE(t, expectedResourceGroupName, expectedClusterName, "")
	require.NoError(t, err)

	// Test that the Nodepool name matches the Terraform specification
	assert.Equal(t, string(expectedDefaultNodePoolName), string(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[1].Name), "Default node pool didn't not match")
	assert.Equal(t, string(expectedUserNodepoolName), string(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[0].Name), "User node pool didn't match")

	// Test that the Node count matches the Terraform specification
	assert.Equal(t, int32(expectedAgentCount), int32(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[0].Count))
	assert.Equal(t, int32(expectedAgentCount), int32(*(*cluster.ManagedClusterProperties.AgentPoolProfiles)[1].Count))

}

func TestAksAddOnProfile(t *testing.T) {
	t.Parallel()

	expectedClusterName := fmt.Sprintf("%s-aks-akscluster-re1-001", os.Getenv("PREFIX"))
	expectedResourceGroupName := fmt.Sprintf("%s-rg-aks-re1", os.Getenv("PREFIX"))

	// Get manged cluster client
	cluster, err := azure.GetManagedClusterE(t, expectedResourceGroupName, expectedClusterName, "")
	require.NoError(t, err)

	// Test if OMS agent is enabled
	assert.Equal(t, true, *(cluster.ManagedClusterProperties.AddonProfiles["omsagent"].Enabled))

	// Test if Azure policy is enabled
	assert.Equal(t, true, *(cluster.ManagedClusterProperties.AddonProfiles["azurepolicy"].Enabled))
}

func TestAksLoadBalancerProfile(t *testing.T) {
	t.Parallel()

	expectedClusterName := fmt.Sprintf("%s-aks-akscluster-re1-001", os.Getenv("PREFIX"))
	expectedResourceGroupName := fmt.Sprintf("%s-rg-aks-re1", os.Getenv("PREFIX"))

	// Get manged cluster client
	cluster, err := azure.GetManagedClusterE(t, expectedResourceGroupName, expectedClusterName, "")
	require.NoError(t, err)

	// Test Network type (plugin) is Azure
	assert.Equal(t, string("azure"), string(cluster.NetworkProfile.NetworkPlugin))
}

func TestAksNetworkProfile(t *testing.T) {
	t.Parallel()

	expectedClusterName := fmt.Sprintf("%s-aks-akscluster-re1-001", os.Getenv("PREFIX"))
	expectedResourceGroupName := fmt.Sprintf("%s-rg-aks-re1", os.Getenv("PREFIX"))
	expectedManagedOutboundIpCount := 1

	// Get manged cluster client
	cluster, err := azure.GetManagedClusterE(t, expectedResourceGroupName, expectedClusterName, "")
	require.NoError(t, err)

	// Test loadbalancer managed outbound IP count
	assert.Equal(t, int32(expectedManagedOutboundIpCount), int32(*(*&cluster.ManagedClusterProperties.NetworkProfile.LoadBalancerProfile.ManagedOutboundIPs.Count)))

}

func TestAksRbacEnbaled(t *testing.T) {
	t.Parallel()

	expectedClusterName := fmt.Sprintf("%s-aks-akscluster-re1-001", os.Getenv("PREFIX"))
	expectedResourceGroupName := fmt.Sprintf("%s-rg-aks-re1", os.Getenv("PREFIX"))

	// Get manged cluster client
	cluster, err := azure.GetManagedClusterE(t, expectedResourceGroupName, expectedClusterName, "")
	require.NoError(t, err)

	// Test cluster is RBAC emnabled
	assert.Equal(t, true, *(cluster.ManagedClusterProperties.EnableRBAC))

}

// func TestAksConfigurationSettings(t *testing.T) {
// 	t.Parallel()

// 	options := k8s.NewKubectlOptions(fmt.Sprintf("%s-aks-akscluster-re1-001-admin", os.Getenv("PREFIX")), os.Getenv("KUBECONFIGPATH"), "cluster-baseline-settings")
// 	//kubectl get pods -l app=csi-secrets-store -n kube-system
// 	//output, err := k8s.RunKubectlAndGetOutputE(t, options, "get", "pods", "-l", "app=csi-secrets-store", "-n", "cluster-baseline-settings")
// 	//require.NoError(t, err)
// 	//require.Equal(t, output, "yes")

// 	// Test CSI provider pods
// 	csiDriverPods := k8s.ListPods(t, options, metav1.ListOptions{LabelSelector: "app=csi-secrets-store"})
// 	for key := range csiDriverPods {
// 		err := k8s.WaitUntilPodAvailableE(t, options, csiDriverPods[key].Name, 60, 1*time.Second)
// 		require.NoError(t, err)
// 	}

// 	// Test Azure Key Vault CSI provider pods
// 	csiAzKeyVaultProviderPods := k8s.ListPods(t, options, metav1.ListOptions{LabelSelector: "app=csi-secrets-store-provider-azure"})
// 	for key := range csiAzKeyVaultProviderPods {
// 		err := k8s.WaitUntilPodAvailableE(t, options, csiAzKeyVaultProviderPods[key].Name, 60, 1*time.Second)
// 		require.NoError(t, err)

// 	}
// }

// func TestDefaultNamespace(t *testing.T) {
// 	t.Parallel()

// 	options := k8s.NewKubectlOptions(fmt.Sprintf("%s-aks-akscluster-re1-001-admin", os.Getenv("PREFIX")), os.Getenv("KUBECONFIGPATH"), "cluster-baseline-settings")
// 	namespaceName := strings.ToLower("a0008")
// 	namespace := k8s.GetNamespace(t, options, namespaceName)
// 	require.Equal(t, namespace.Name, namespaceName)
// }

func TestAKSManagedAad(t *testing.T) {
	t.Parallel()
	//TODO
}

func GetConfigurationVarFiles(root, pattern string) ([]string, error) {
	var matches []string
	err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if info.IsDir() {
			return nil
		}
		if matched, err := filepath.Match(pattern, filepath.Base(path)); err != nil {
			return err
		} else if matched {
			matches = append(matches, path)
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return matches, nil
}
