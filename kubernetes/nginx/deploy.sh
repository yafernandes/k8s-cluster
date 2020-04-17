kubectl create ns nginx-ingress

kubectl apply -f nginx-configmap.yaml -n nginx-ingress

helm install nginx-ingress stable/nginx-ingress -f nginx-values.yaml -n nginx-ingress