# Kubernetes

## Technologie specific deltas

### Istio

```yaml
datadog:
  confd:
    istio.yaml: |-
      ad_identifiers:
        - proxyv2
      init_config:
      instances:
        - istio_mesh_endpoint: http://%%host%%:15090/stats/prometheus
          send_histograms_buckets: true
          send_monotonic_counter: true
agents:
  podAnnotations:
    sidecar.istio.io/inject: "false"
  volumeMounts:
    - mountPath: /etc/datadog-agent/conf.d/istio.d
      name: empty-dir
  volumes:
    - name: empty-dir
      emptyDir: {}
clusterAgent:
  podAnnotations:
    sidecar.istio.io/inject: "false"
  confd:
    istio.yaml: |-
      cluster_check: true
      init_config:
      instances:
        - istiod_endpoint: http://istio-pilot.istio-system:8080/metrics
```

### Proxy
```yaml
datadog:
  env:
    - name: HTTP_PROXY
      value: http://proxy.k8s.aws.pipsquack.ca:3128/
    - name: HTTPS_PROXY
      value: http://proxy.k8s.aws.pipsquack.ca:3128/
```

### Kubelet read only port not available
```yaml
datadog:
  env:
    - name: DD_KUBELET_TLS_VERIFY
      value: false
```
