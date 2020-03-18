# https://hub.helm.sh/charts/stable/datadog
# https://github.com/helm/charts/tree/master/stable/datadog#configuration

kubectl create ns datadog

kubectl create secret generic dd --from-env-file=secrets.txt -n datadog

helm install datadog stable/datadog -f datadog-values.yaml -n datadog

kubectl create ns nginx-ingress

kubectl apply -f nginx-configmap.yaml -n nginx-ingress

helm install nginx-ingress stable/nginx-ingress -f nginx-values.yaml -n nginx-ingress

kubectl apply -f stresser.yaml

kubectl apply -f app-node.yaml
