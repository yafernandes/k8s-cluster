# k8s-cluster
Scripts to create a Kubernetes cluster in AWS, including Datadog agent.

## v1.19
In version 1.19, the scheduler and controllers do not listen on HTTP.  To revert to 1.18 behaviour, edit the static pod definitions (`/etc/kubernetes/manifests`) in the master nodes and remove the line `- --port=0`.