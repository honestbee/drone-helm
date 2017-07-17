FROM alpine:3.6
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>


RUN apk -Uuv add curl bash && rm /var/cache/apk/*

ENV VERSION v2.5.0
ENV FILENAME helm-${VERSION}-linux-amd64.tar.gz
ENV KUBECTL v1.6.6

RUN set -ex \
  && curl -o /tmp/${FILENAME} http://storage.googleapis.com/kubernetes-helm/${FILENAME} \
  && curl -o /tmp/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL}/bin/linux/amd64/kubectl \
  && tar -zxvf /tmp/${FILENAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && chmod +x /tmp/kubectl \
  && mv /tmp/kubectl /bin/kubectl \
  && rm -rf /tmp

LABEL description="Kubeclt and Helm."
LABEL base="alpine"
LABEL language="golang"


COPY bin/drone-helm /bin/drone-helm
COPY kubeconfig /root/.kube/kubeconfig

ENTRYPOINT [ "/bin/drone-helm" ]
