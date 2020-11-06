# Kubernetes

### Proxy

The value in the `no_proxy` variable are:
- k8s.aws.pipsquack.ca - Host domain
- local - Kubernetes dns zone - `kubectl describe configmap coredns -n kube-system`
- 10.0.0.0/16 - VPC address space
- 172.16.0.0/12 - Kubernets service address space - `/etc/kubernetes/manifests/kube-controller-manager.yaml`
- 192.168.0.0/16 - Kubernetes pods address space - `/etc/kubernetes/manifests/kube-controller-manager.yaml`
