FROM frolvlad/alpine-oraclejdk8
MAINTAINER Ilkka Anttonen version: 0.6

ENV ELASTICSEARCH_VERSION=2.1.1 \
  LOGSTASH_VERSION=2.1.1

# To get the https-downloads functional, also install bash that some scripts expect
RUN apk --update add wget bash

# Create the elasticsearch user as it cannot be run as root any more
RUN adduser -S elasticsearch

# Install gosu - a tool to execute a command as another user:
RUN wget --no-check-certificate -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 && \
  chmod 755 /usr/local/bin/gosu

# Set up runit
COPY runsv /sbin/runsv
COPY runsvdir /sbin/runsvdir

RUN ( mkdir -p /opt/elasticsearch-${ELASTICSEARCH_VERSION} && \
  chown elasticsearch /opt/elasticsearch-${ELASTICSEARCH_VERSION} )

# Install and run Elasticsearch as a user as it can't be run as root any more
USER elasticsearch

RUN ( wget http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz -O /tmp/elasticsearch.tar.gz && \
  gunzip /tmp/elasticsearch.tar.gz && \
  cd /opt && \
  tar xf /tmp/elasticsearch.tar && \
  rm /tmp/elasticsearch.tar )

USER root

# Install Logstash
RUN ( wget http://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz -O /tmp/logstash.tar.gz && \
  gunzip /tmp/logstash.tar.gz && \
  cd /opt && \
  tar xf /tmp/logstash.tar && \
  rm /tmp/logstash.tar )

# Set the scripts in place
RUN ( mkdir -p /etc/service/elasticsearch && \
    echo -e "#!/bin/sh\ngosu elasticsearch /opt/elasticsearch-${ELASTICSEARCH_VERSION}/bin/elasticsearch" > /etc/service/elasticsearch/run && \
    chmod u+x /etc/service/elasticsearch/run )
# By default open the elasticsearch container, only expose it to relevant clients!
RUN echo -e "network.host: 0.0.0.0" > /opt/elasticsearch-${ELASTICSEARCH_VERSION}/config/elasticsearch.yml

RUN ( mkdir -p /etc/service/logstash && \
    echo -e "#!/bin/sh\n/opt/logstash-${LOGSTASH_VERSION}/bin/logstash -f /etc/logstash-syslog.json" > /etc/service/logstash/run && \
    chmod u+x /etc/service/logstash/run )

COPY logstash-syslog.json /etc/logstash-syslog.json

# Expose the ports
EXPOSE 5000 9200

# Start runit
CMD ["/sbin/runsvdir", "/etc/service"]
