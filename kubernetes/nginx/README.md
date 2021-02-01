# [AKS](https://docs.microsoft.com/en-us/azure/aks/ingress-static-ip)

- Create a Standard Public IP in the [node resource group](https://docs.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks) of your AKS cluster.
- Get the public ip from the resource and update [nginx-values.yaml](nginx-values.yaml).
- Deploy [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) using Helm.

https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx

```bash
 helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx -f nginx/nginx-values.yaml
```
