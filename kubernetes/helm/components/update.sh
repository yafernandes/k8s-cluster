yq m -a append etcd.yaml base.yaml > ../datadog-values.yaml
yq m -a append openshift4.yaml base.yaml > ../datadog-values-openshift4.yaml
yq m -a append proxy.yaml base.yaml > ../datadog-values-proxy.yaml
yq m -a append eks.yaml base.yaml > ../datadog-values-eks.yaml
yq m -a append aks.yaml base.yaml > ../datadog-values-aks.yaml
