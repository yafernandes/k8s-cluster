LOC=$(cd `dirname $0` && pwd)

cd ${LOC}/terraform
terraform apply --auto-approve

cd ${LOC}/ansible
ansible-playbook -i inventory.txt main.yaml

cd ${LOC}/kubernetes
./dashboard-setup.sh
./datadog-setup.sh
