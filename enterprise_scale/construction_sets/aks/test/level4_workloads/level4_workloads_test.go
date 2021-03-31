package workloads

// import (
// 	"fmt"
// 	"os"
// 	"strings"
// 	"testing"
// 	"time"

// 	"github.com/stretchr/testify/require"
// )

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
