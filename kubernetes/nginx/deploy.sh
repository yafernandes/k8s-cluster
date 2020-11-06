kubectl create ns nginx-ingress

helm install nginx-ingress nginx-stable/nginx-ingress -f nginx-values.yaml -n nginx-ingress
