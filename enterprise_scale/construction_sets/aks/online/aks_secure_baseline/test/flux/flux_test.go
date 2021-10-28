package flux

import (
	"fmt"
	"os"
	"secureaks/tests/util"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/stretchr/testify/require"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type ExpectedValues struct {
	K8sContextName           string
	ClusterBaselineNamespace string
}

func TestCSIProvider(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	options := getKubectlOptions(expectedValues.K8sContextName, expectedValues.ClusterBaselineNamespace)

	// Test CSI provider pods
	csiDriverPods := k8s.ListPods(t, options, metav1.ListOptions{LabelSelector: "app=csi-secrets-store"})
	for key := range csiDriverPods {
		err := k8s.WaitUntilPodAvailableE(t, options, csiDriverPods[key].Name, 60, 1*time.Second)
		require.NoError(t, err)
	}

	// Test Azure Key Vault CSI provider pods
	csiAzKeyVaultProviderPods := k8s.ListPods(t, options, metav1.ListOptions{LabelSelector: "app=csi-secrets-store-provider-azure"})
	for key := range csiAzKeyVaultProviderPods {
		err := k8s.WaitUntilPodAvailableE(t, options, csiAzKeyVaultProviderPods[key].Name, 60, 1*time.Second)
		require.NoError(t, err)

	}
}

func TestFlux(t *testing.T) {
	t.Parallel()
	expectedValues := getExpectedValues()

	options := getKubectlOptions(expectedValues.K8sContextName, expectedValues.ClusterBaselineNamespace)
	fluxpods := k8s.ListPods(t, options, metav1.ListOptions{LabelSelector: "app.kubernetes.io/name=flux"})
	for key := range fluxpods {
		err := k8s.WaitUntilPodAvailableE(t, options, fluxpods[key].Name, 60, 1*time.Second)
		require.NoError(t, err)

	}
}

func TestAadPodIdentityControllers(t *testing.T) {
	t.Parallel()
	expectedValues := getExpectedValues()

	options := getKubectlOptions(expectedValues.K8sContextName, expectedValues.ClusterBaselineNamespace)
	aadpods := k8s.ListPods(t, options, metav1.ListOptions{LabelSelector: "app.kubernetes.io/name=aad-pod-identity"})
	for key := range aadpods {
		err := k8s.WaitUntilPodAvailableE(t, options, aadpods[key].Name, 60, 1*time.Second)
		require.NoError(t, err)
	}
}

// func TestKuredControllers(t *testing.T) {
// 	t.Parallel()
// 	expectedValues := getExpectedValues()

// 	options := getKubectlOptions(expectedValues.K8sContextName, expectedValues.ClusterBaselineNamespace)
// 	kuredpods := k8s.ListPods(t, options, metav1.ListOptions{LabelSelector: "name=kured"})
// 	for key := range kuredpods {
// 		err := k8s.WaitUntilPodAvailableE(t, options, kuredpods[key].Name, 60, 1*time.Second)
// 		require.NoError(t, err)

// 	}
// }

func getKubectlOptions(contextName, namespace string) *k8s.KubectlOptions {
	return k8s.NewKubectlOptions(util.ResolveNameWithPrefix(contextName), os.Getenv("KUBECONFIGPATH"), namespace)
}

func getExpectedValues() ExpectedValues {
	var expectedValues ExpectedValues
	util.ReadTestConfig("ExpectedValues", &expectedValues)
	fmt.Printf("context %s", expectedValues.K8sContextName)
	return expectedValues
}
