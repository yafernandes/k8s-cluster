##https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/
kubectl apply -f https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml
kubectl apply -f https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml
kubectl apply -f https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml

kubectl apply -f https://github.com/DataDog/datadog-agent/raw/master/Dockerfiles/manifests/cluster-agent/rbac/rbac-cluster-agent.yaml

# Kubernetes Event Collection
# https://docs.datadoghq.com/agent/kubernetes/event_collection/
kubectl create configmap datadogtoken --from-literal="event.tokenKey"="0"

kubectl create secret generic dd --from-env-file=secrets.txt

kubectl apply -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/master/examples/standard/service-account.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/master/examples/standard/cluster-role.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/master/examples/standard/cluster-role-binding.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/master/examples/standard/deployment.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kube-state-metrics/master/examples/standard/service.yaml

kubectl apply -f datadog-config.yaml
kubectl apply -f datadog-agent.yaml

kubectl apply -f stresser.yaml