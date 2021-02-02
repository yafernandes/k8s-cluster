kubectl create ns datadog

kubectl create secret generic datadog-keys --from-env-file=secrets.txt -n datadog

kubectl create secret generic datadog-keys --from-env-file=secrets.txt

helm install datadog datadog/datadog -n datadog -f $1
