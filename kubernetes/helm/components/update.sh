yq m -xa append base.yaml etcd.yaml > ../datadog-values-vanilla.yaml
yq m -xa append base.yaml openshift-4.yaml > ../datadog-values-openshift-4.yaml
yq m -xa append base.yaml proxy.yaml > ../datadog-values-proxy.yaml
yq m -xa append base.yaml eks.yaml > ../datadog-values-eks.yaml
yq m -xa append base.yaml aks.yaml > ../datadog-values-aks.yaml
yq m -xa append base.yaml istio-1.5.yaml > ../datadog-values-istio-1.5.yaml

yq m -xa append ../datadog-values-openshift-4.yaml aro.yaml > ../datadog-values-aro.yaml

yq m -xia append ../datadog-values-aks.yaml kubelet.yaml