#!/bin/bash
docker run -d --name logbox -h logbox -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro -p 5000:5000/udp -p 9200:9200 sirile/minilogbox
docker run -d -p 5601:5601 -h kibanabox -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro --name kibanabox sirile/kibanabox http://`docker-machine ip $DOCKER_MACHINE_NAME`:9200
docker run -d --name logspout -h logspout -p 8100:8000 -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro -v /var/run/docker.sock:/tmp/docker.sock progrium/logspout syslog://`docker-machine ip $DOCKER_MACHINE_NAME`:5000
