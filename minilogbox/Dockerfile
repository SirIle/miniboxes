FROM frolvlad/alpine-oraclejdk8
MAINTAINER Ilkka Anttonen version: 0.5

ENV ELASTICSEARCH_VERSION=1.7.0 \
  LOGSTASH_VERSION=1.5.2

# Install bash as it is now required
RUN apk --update add bash

# Set up runit
COPY runsv /sbin/runsv
COPY runsvdir /sbin/runsvdir

# Install Elasticsearch
RUN ( mkdir /opt && wget http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz -O /tmp/elasticsearch.tar.gz && gunzip /tmp/elasticsearch.tar.gz && cd /opt && tar xf /tmp/elasticsearch.tar && rm /tmp/elasticsearch.tar)

# Install Logstash
RUN ( wget http://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz -O /tmp/logstash.tar.gz && gunzip /tmp/logstash.tar.gz && cd /opt && tar xf /tmp/logstash.tar && rm /tmp/logstash.tar )

# Set the scripts in place
RUN ( mkdir -p /etc/service/elasticsearch && \
    echo -e "#!/bin/sh\n/opt/elasticsearch-${ELASTICSEARCH_VERSION}/bin/elasticsearch" > /etc/service/elasticsearch/run && \
    chmod u+x /etc/service/elasticsearch/run )
RUN ( mkdir -p /etc/service/logstash && \
    echo -e "#!/bin/sh\n/opt/logstash-${LOGSTASH_VERSION}/bin/logstash -f /etc/logstash-syslog.json" > /etc/service/logstash/run && \
    chmod u+x /etc/service/logstash/run )
COPY logstash-syslog.json /etc/logstash-syslog.json

# Expose the ports
EXPOSE 5000 9200

# Start runit
CMD ["/sbin/runsvdir", "/etc/service"]
