# https://hub.helm.sh/charts/stable/datadog
# https://github.com/helm/charts/tree/master/stable/datadog#configuration

kubectl create secret generic dd --from-env-file=../secrets.txt

kubectl create -f tiller-rbac-config.yaml
helm init --service-account tiller

# kubectl apply -f ../metrics-server/deploy/1.8+

# read -p "Press [Enter] to contiue..."

sleep 60

helm install -f datadog-values.yaml --name datadog stable/datadog

kubectl apply -f nginx-configmap.yaml

helm install -f nginx-values.yaml --name nginx stable/nginx-ingress

helm install -f dashboard-values.yaml --name dashboard stable/kubernetes-dashboard

# helm upgrade -f datadog-values.yaml datadog stable/datadog --recreate-pods

kubectl apply -f ../stresser.yaml