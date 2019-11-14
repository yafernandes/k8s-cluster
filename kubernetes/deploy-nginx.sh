
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/service-nodeport.yaml

kubectl patch deployment nginx-ingress-controller -n ingress-nginx --patch "
spec:
    template:
        spec:
            containers:
                - name: nginx-ingress-controller
                  env:
                    - name: HOST_IP
                      valueFrom:
                        fieldRef:
                          fieldPath: status.hostIP
"

kubectl apply -f deploy-nginx.yaml

