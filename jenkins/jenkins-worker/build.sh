#!/bin/bash

cp ~/.kube/config .
K8S_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
docker build . -t yaalexf/jenkins-worker --build-arg K8S_VERSION=$K8S_VERSION
docker push yaalexf/jenkins-worker
