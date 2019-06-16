# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
kubectl apply -f dashboard.yaml
kubectl config set-credentials kubernetes-admin --token=$(kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep kubernetes-admin | awk '{print $1}') | grep ^token: | awk '{print $2}')