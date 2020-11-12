# Kubernetes

## QuickStart

- Create a text file with the structure below. You can get your API Key in [here](https://app.datadoghq.com/account/settings#api).  The 32 long token will be used to secure communication between the node Agent and the Datadog Cluster Agent. You can generate one online [here](http://www.unit-conversion.info/texttools/random-string-generator/).

```text
api-key=<API KEY>
token=<32 characters long token>
```

- Create a `datadog` namespace.

```shell
kubectl create ns datadog
```

- Create the secret using the file created ealier.

```shell
kubectl create secret generic datadog-keys --from-env-file=secrets.txt
```

- Download the [values file](helm) for your Kubernetes flavour. Update values like `datadog.clusterName` and `DD_ENV`. If creating a secret with a different name in the previous step, update `datadog.apiKeyExistingSecret`.

- Deploy Datadog using the updated values file.

```shell
helm install datadog datadog/datadog -n datadog -f <values file>
```

I highly recommend exploring the [new curated views for Kubernetes](https://www.datadoghq.com/blog/explore-kubernetes-resources-with-datadog/). The values file provided also enables the new [Admission Controller](https://docs.datadoghq.com/agent/cluster_agent/admission_controller), simplifing the user’s application pod configuration.

If you want to validate the resources being deployed first, you can still use helm to just output it.

```shell
helm template datadog datadog/datadog -n datadog -f <values file>
```

## Installing Datadog Helm Charts

```shell
helm repo add datadog https://helm.datadoghq.com
helm repo update
```

[Documentation](https://github.com/DataDog/helm-charts/tree/master/charts/datadog)

## Proxy

The values in the `no_proxy` variable are:

- k8s.aws.pipsquack.ca - Hosts domain
- cluster.local - Kubernetes dns zone - `kubectl describe configmap coredns -n kube-system`
- 10.0.0.0/16 - Cluster address space
- 172.16.0.0/12 - Kubernets service address space - `/etc/kubernetes/manifests/kube-controller-manager.yaml`
- 192.168.0.0/16 - Kubernetes pods address space - `/etc/kubernetes/manifests/kube-controller-manager.yaml`
