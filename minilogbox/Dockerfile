FROM progrium/busybox
MAINTAINER Ilkka Anttonen version: 0.2

# Udate wget to support SSL
RUN opkg-install wget

# Get and install Java
RUN ( wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jre.tar.gz http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jre-8u40-linux-x64.tar.gz &&   gunzip /tmp/jre.tar.gz && cd /opt && tar xf /tmp/jre.tar && rm /tmp/jre.tar)

# Link Java into use, wget-ssl updates libpthread which causes Java to break
RUN ln -sf /lib/libpthread-2.18.so /lib/libpthread.so.0 && ln -s /opt/jre1.8.0_40/bin/java /usr/bin/java

# Set up runit
COPY runsv /sbin/runsv
COPY runsvdir /sbin/runsvdir

# Install Elasticsearch
RUN ( wget http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.tar.gz -O /tmp/elasticsearch.tar.gz && gunzip /tmp/elasticsearch.tar.gz && cd /opt && tar xf /tmp/elasticsearch.tar && rm /tmp/elasticsearch.tar)

# Install Logstash
RUN ( wget http://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz -O /tmp/logstash.tar.gz && gunzip /tmp/logstash.tar.gz && cd /opt && tar xf /tmp/logstash.tar && rm /tmp/logstash.tar )

# Set the scripts in place
COPY elasticsearch /etc/service/elasticsearch/run
COPY logstash /etc/service/logstash/run
COPY logstash-syslog.json /opt/logstash-1.4.2/logstash-syslog.json

# Expose the ports
EXPOSE 5000 9200

# Start runit
CMD ["/sbin/runsvdir", "/etc/service"]
