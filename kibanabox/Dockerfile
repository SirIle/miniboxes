# Docker image to run Kibana on nginx
FROM progrium/busybox
MAINTAINER Ilkka Anttonen version: 0.2

RUN ( opkg-install libstdcpp && ln -s /lib/libc.so.0 /lib/libc.so )

# Install Kibana
RUN ( wget --no-check-certificate http://download.elastic.co/kibana/kibana/kibana-4.1.0-linux-x64.tar.gz -O /tmp/kibana.tar.gz && gunzip /tmp/kibana.tar.gz && cd /opt && tar xf /tmp/kibana.tar && rm /tmp/kibana.tar)

# Check how to preconfigure kibana to default to logstash dashboard

# Start kibana, elasticsearch instance can be overridden
ENTRYPOINT ["/opt/kibana-4.1.0-linux-x64/bin/kibana","-e"]
CMD ["localhost:9200"]
