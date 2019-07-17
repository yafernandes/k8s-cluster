LOC=$(cd `dirname $0` && pwd)

cd ${LOC}/terraform
terraform destroy --auto-approve