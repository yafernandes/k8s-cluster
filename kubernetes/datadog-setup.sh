# https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/
kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml"
kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml"
kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml"

# Kubernetes Event Collection
# https://docs.datadoghq.com/agent/kubernetes/event_collection/
kubectl create configmap datadogtoken --from-literal="event.tokenKey"="0"

kubectl create secret generic dd --from-env-file=secrets.txt

kubectl apply -f datadog-agent.yaml

# https://docs.datadoghq.com/integrations/kubernetes/#kubernetes-state-metrics
# https://docs.datadoghq.com/agent/kubernetes/host_setup/
# kubectl apply -f kube-state-metrics/kubernetes