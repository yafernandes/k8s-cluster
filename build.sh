set -e

LOC=$(cd `dirname $0` && pwd)
USERNAME=admin

cd ${LOC}/terraform
terraform apply --auto-approve

echo master ansible_host=master.k8s.aws.pipsquack.ca ansible_connection=ssh ansible_user=$USERNAME ansible_ssh_private_key_file=/Users/alex.fernandes/.ssh/alexf-key.pem > ${LOC}/ansible/inventory.txt
for ENTRY in $(terraform output -json workers | jq --raw-output '.[]')
do
    echo $(echo $ENTRY | cut -f 1 -d .) ansible_host=$ENTRY ansible_connection=ssh ansible_user=$USERNAME ansible_ssh_private_key_file=/Users/alex.fernandes/.ssh/alexf-key.pem >> ${LOC}/ansible/inventory.txt
done

echo [workers] >> ${LOC}/ansible/inventory.txt
for ENTRY in $(terraform output -json workers | jq --raw-output '.[]')
do
    echo $(echo $ENTRY | cut -f 1 -d .) >> ${LOC}/ansible/inventory.txt
done

cd ${LOC}/ansible
ansible-playbook -i inventory.txt main.yaml

# cd ${LOC}/kubernetes
# ./dashboard-setup.sh
# ./datadog-setup.sh

cd ${LOC}/kubernetes/helm
./deploy.sh

