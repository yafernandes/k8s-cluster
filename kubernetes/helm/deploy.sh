# https://hub.helm.sh/charts/stable/datadog
# https://github.com/helm/charts/tree/master/stable/datadog#configuration

kubectl create secret generic dd --from-env-file=../secrets.txt

# kubectl apply -f ../metrics-server/deploy/1.8+

helm install datadog stable/datadog -f datadog-values.yaml

kubectl apply -f nginx-configmap.yaml

helm install nginx stable/nginx-ingress -f nginx-values.yaml

helm install dashboard stable/kubernetes-dashboard -f dashboard-values.yaml

# helm upgrade -f datadog-values.yaml datadog stable/datadog --recreate-pods

kubectl apply -f ../stresser.yaml