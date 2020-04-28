kubectl label namespace default istio-injection=enabled

istioctl manifest apply -f istio-config.yaml

kubectl apply -f istio-ingress.yaml
