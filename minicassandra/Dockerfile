FROM frolvlad/alpine-oraclejdk8
MAINTAINER Ilkka Anttonen version: 0.1
# Version of Cassandra to install
ENV CASSANDRA_VERSION=2.1.9
# Install curl, joe and python
RUN apk --update add curl joe python libstdc++
# Get Cassandra, unpack and rename the directory so that start script dowsn't need to know the version
RUN ( curl -L http://downloads.datastax.com/community/dsc-cassandra-${CASSANDRA_VERSION}-bin.tar.gz | tar xz && \
  mv dsc-cassandra-${CASSANDRA_VERSION} cassandra )
# Expose ports
EXPOSE 7000 7199 9042 9160
# Copy the startup-script over
COPY start.sh /start.sh
RUN chmod u+x /start.sh
ENTRYPOINT ["/start.sh"]
CMD ["127.0.0.1"]
