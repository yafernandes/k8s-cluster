# https://hub.helm.sh/charts/stable/datadog
# https://github.com/helm/charts/tree/master/stable/datadog#configuration

kubectl create ns datadog

kubectl create secret generic datadog-keys --from-env-file=secrets.txt -n datadog

kubectl create secret generic datadog-keys --from-env-file=secrets.txt

helm install datadog datadog/datadog -f datadog-values.yaml -n datadog
