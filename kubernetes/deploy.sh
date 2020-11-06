# https://hub.helm.sh/charts/stable/datadog
# https://github.com/helm/charts/tree/master/stable/datadog#configuration

kubectl config current-context alex@kubernetes

kubectl create ns datadog

kubectl create secret generic datadog-keys --from-env-file=secrets.txt -n datadog

kubectl create secret generic datadog-keys --from-env-file=secrets.txt

helm install datadog datadog/datadog -f helm/datadog-values.yaml -n datadog
