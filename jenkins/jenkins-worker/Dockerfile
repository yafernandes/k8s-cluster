FROM alpine
ARG K8S_VERSION=v1.17.2
RUN set -x                  && \
    apk --update upgrade    && \
    apk add ca-certificates && \
    wget -O /kubectl https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl && \
    chmod +x /kubectl
COPY latest.yaml /
COPY previous.yaml /
COPY config /root/.kube/