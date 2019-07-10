kubectl apply -f hhttps://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
kubectl apply -f dashboard.yaml
kubectl config set-credentials kubernetes-admin --token=$(kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep kubernetes-admin | awk '{print $1}') | grep ^token: | awk '{print $2}')