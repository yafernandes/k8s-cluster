LOC=$(cd `dirname $0` && pwd)

cd ${LOC}/terraform
terraform apply --auto-approve

cd ${LOC}/ansible
ansible-playbook -i inventory.txt prereqs.yaml
ansible-playbook -i inventory.txt kubernetes.yaml

cd ${LOC}/kubernetes
./dashboard-setup.sh
kubectl apply -f kube-state-metrics
./datadog-setup.sh
