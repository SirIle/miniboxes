FROM progrium/busybox
MAINTAINER Ilkka Anttonen version: 0.4

# Udate wget to support SSL, also install bash as logstash now requires it
RUN opkg-install wget bash

RUN ( wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jre.tar.gz http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jre-8u45-linux-x64.tar.gz && \
  echo '58486d7b16d7b21fbea7374adc109233  /tmp/jre.tar.gz' > checksum && \
  md5sum -c checksum && \
  rm checksum && \
  gunzip /tmp/jre.tar.gz && cd /opt && tar xf /tmp/jre.tar && rm /tmp/jre.tar && \
  rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/lib/plugin.jar \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so )

# Link Java into use, wget-ssl updates libpthread which causes Java to break
RUN ln -sf /lib/libpthread-2.18.so /lib/libpthread.so.0 && ln -s /opt/jre1.8.0_45/bin/java /usr/bin/java

# Set up runit
COPY runsv /sbin/runsv
COPY runsvdir /sbin/runsvdir

# Install Elasticsearch
RUN ( wget http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.6.0.tar.gz -O /tmp/elasticsearch.tar.gz && gunzip /tmp/elasticsearch.tar.gz && cd /opt && tar xf /tmp/elasticsearch.tar && rm /tmp/elasticsearch.tar)

# Install Logstash
RUN ( wget http://download.elasticsearch.org/logstash/logstash/logstash-1.5.1.tar.gz -O /tmp/logstash.tar.gz && gunzip /tmp/logstash.tar.gz && cd /opt && tar xf /tmp/logstash.tar && rm /tmp/logstash.tar )

# Set the scripts in place
COPY elasticsearch /etc/service/elasticsearch/run
COPY logstash /etc/service/logstash/run
COPY logstash-syslog.json /opt/logstash-1.5.1/logstash-syslog.json

# Expose the ports
EXPOSE 5000 9200

# Start runit
CMD ["/sbin/runsvdir", "/etc/service"]
