#!/bin/bash

helm install jenkins stable/jenkins -f jenkins-values.yaml

cd jenkins-worker
./build.sh
cd -

echo "Waiting for Jenkins to go on Running state"
kubectl get pods -w | grep -m 1 "jenkins.*1/1.*Running"

curl -d @latest.xml http://jenkins.k8s.aws.pipsquack.ca:30080/createItem?name=Deploy --header "Content-Type:application/xml"
curl -d @previous.xml http://jenkins.k8s.aws.pipsquack.ca:30080/createItem?name=Rollback --header "Content-Type:application/xml"

kubectl apply -f jenkins-worker/previous.yaml
