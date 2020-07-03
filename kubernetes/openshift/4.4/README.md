# Sample OpenShift 4.x configuration
Tested on [OpenShift 4.4/CodeReady Containers](https://github.com/code-ready/crc)

This configuration assumes that the agent is deployed in the `datadog` namespace and using default service account names. Please update [scc.yaml](https://github.com/yafernandes/k8s-cluster/blob/6ff71efcb987c2225281adcb9fff395126bf3e6b/kubernetes/openshift/4.4/scc.yaml#L11) to reflect your specific situation. The format should be:

`- system:serviceaccount:<namespace>:<service account>`
