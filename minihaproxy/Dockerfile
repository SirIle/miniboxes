FROM progrium/busybox
MAINTAINER Ilkka Anttonen version: 0.1

# Updata wget to get support for SSL
RUN opkg-install haproxy wget

# Download consul-template
RUN ( wget  --no-check-certificate https://github.com/hashicorp/consul-template/releases/download/v0.8.0/consul-template_0.8.0_linux_amd64.tar.gz -O /tmp/consul_template.tar.gz && gunzip /tmp/consul_template.tar.gz && cd /tmp && tar xf /tmp/consul_template.tar && cd /tmp/consul-template* && mv consul-template /usr/bin && rm -rf /tmp/* )

COPY files/haproxy.json /tmp/haproxy.json
COPY files/haproxy.ctmpl /tmp/haproxy.ctmpl

CMD ["consul-template", "-config=/tmp/haproxy.json"]
