set -e

LOC=$(cd `dirname $0` && pwd)
USERNAME=ubuntu

cd ${LOC}/terraform
terraform apply --auto-approve

sed -i .bak /k8s.aws.pipsquack.ca/d ~/.ssh/known_hosts
sed -i .bak /master/d ~/.ssh/known_hosts
sed -i .bak /worker/d ~/.ssh/known_hosts

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

