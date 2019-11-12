# https://hub.helm.sh/charts/stable/datadog
# https://github.com/helm/charts/tree/master/stable/datadog#configuration

kubectl create secret generic dd --from-env-file=../secrets.txt

kubectl create -f tiller-rbac-config.yaml
helm init --service-account tiller

# kubectl apply -f ../metrics-server/deploy/1.8+

read -p "Press [Enter] to contiue..."

helm install -f values.yaml --name datadog-monitoring stable/datadog

# helm upgrade -f values.yaml datadog-monitoring stable/datadog --recreate-pods