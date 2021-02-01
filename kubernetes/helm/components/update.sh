# yq eval-all \
#   'select(fileIndex==0) * select(fileIndex==1) * select(fileIndex==2)' \
#   base.yaml etcd.yaml containerd.yaml \
#   > ../datadog-values-kubeadm.yaml

# yq eval-all \
#   'select(fileIndex==0) * select(fileIndex==1)' \
#   base.yaml openshift-4.yaml \
#   > ../datadog-values-openshift-4.yaml

# yq eval-all \
#   'select(fileIndex==0) * select(fileIndex==1) * select(fileIndex==2)' \
#   base.yaml openshift-4.yaml aro.yaml \
#   > ../datadog-values-openshift-4.yaml

# yq eval-all \
#   'select(fileIndex==0) * select(fileIndex==1) * select(fileIndex==2)' \
#   base.yaml apiserver-svc.yaml aks.yaml \
#   > ../datadog-values-aks.yaml

# yq eval-all \
#   'select(fileIndex==0) * select(fileIndex==1) * select(fileIndex==2)' \
#   base.yaml apiserver-svc.yaml eks.yaml \
#   > ../datadog-values-eks.yaml

# yq eval-all \
#   'select(fileIndex==0) * select(fileIndex==1)' \
#   base.yaml istio-1.5.yaml \
#   > ../datadog-values-istio-1.5.yaml

# yq eval-all \
#   'select(fileIndex==0) *+ select(fileIndex==1)' \
#   base.yaml proxy.yaml \
#   > ../datadog-values-proxy.yaml

cp base.yaml ../datadog-values-kubeadm.yaml
yq m -xia append ../datadog-values-kubeadm.yaml apiserver-svc.yaml
yq m -xia append ../datadog-values-kubeadm.yaml etcd.yaml
yq m -xia append ../datadog-values-kubeadm.yaml containerd.yaml

yq m -xa append base.yaml openshift-4.yaml > ../datadog-values-openshift-4.yaml

yq m -xa append base.yaml proxy.yaml > ../datadog-values-proxy.yaml

cp base.yaml ../datadog-values-eks.yaml
yq m -xia append ../datadog-values-eks.yaml apiserver-svc.yaml
yq m -xia append ../datadog-values-eks.yaml eks.yaml

cp base.yaml ../datadog-values-aks.yaml
yq m -xia append ../datadog-values-aks.yaml apiserver-svc.yaml
yq m -xia append ../datadog-values-aks.yaml kubelet-host.yaml

yq m -xa append base.yaml istio-1.5.yaml > ../datadog-values-istio-1.5.yaml

yq m -xa append ../datadog-values-openshift-4.yaml aro.yaml > ../datadog-values-aro.yaml
