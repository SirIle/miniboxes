# Docker image to run Kibana on nginx
FROM alpine
MAINTAINER Ilkka Anttonen version: 0.5

ENV KIBANA_VERSION=4.3.1

# Install Kibana
RUN ( mkdir /opt && \
  wget http://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz -O /tmp/kibana.tar.gz && \
  gunzip /tmp/kibana.tar.gz && \
  cd /opt && \
  tar xf /tmp/kibana.tar && \
  rm /tmp/kibana.tar && \
  rm -rf /opt/kibana-${KIBANA_VERSION}-linux-x64/node && \
  ln -s /opt/kibana-${KIBANA_VERSION}-linux-x64/bin/kibana /usr/bin/kibana )

# Override the provided node with a Alpine version
RUN ( apk --update add nodejs && \
  mkdir -p /opt/kibana-${KIBANA_VERSION}-linux-x64/node/bin && \
  ln -s /usr/bin/node /opt/kibana-${KIBANA_VERSION}-linux-x64/node/bin/node )

# Check how to preconfigure kibana to default to logstash dashboard

# Start kibana, elasticsearch instance can be overridden
ENTRYPOINT ["kibana","-e"]
CMD ["localhost:9200"]
