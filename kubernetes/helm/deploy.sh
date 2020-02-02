# https://hub.helm.sh/charts/stable/datadog
# https://github.com/helm/charts/tree/master/stable/datadog#configuration

kubectl create ns datadog

kubectl create secret generic dd --from-env-file=../secrets.txt -n datadog

helm install datadog stable/datadog -f datadog-values.yaml -n datadog

kubectl apply -f nginx-configmap.yaml

helm install nginx stable/nginx-ingress -f nginx-values.yaml

# helm install dashboard stable/kubernetes-dashboard -f dashboard-values.yaml
kubectl apply -f dashboard-v2.yaml

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv0001
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: slow
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /
    server: $(terraform output -state=../../terraform/terraform.tfstate nfs)
EOF

kubectl apply -f ../stresser.yaml

kubectl apply -f ../app-node.yaml
