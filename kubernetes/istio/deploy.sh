kubectl label namespace default istio-injection=enabled

istioctl manifest apply -f istio-config.yaml

kubectl delete -f ../apps/app-node.yaml

kubectl apply -f ../apps/app-node.yaml

kubectl apply -f istio-ingress.yaml
