#!/usr/bin/env bash

SERVICE="radarr"
IMAGE="bluefishforsale/radarr"
VERSION="latest"
LOCALDIR="/data01/services/${SERVICE}"
DOWNLOADS="/data01/incoming/movies"
COMPLETE="/data01/complete/movies"

test  -d ${LOCALDIR}  || mkdir -p ${LOCALDIR}

docker stop ${SERVICE}
docker rm ${SERVICE}


sudo docker run -d \
  --restart=always \
  --name=${SERVICE} \
  --hostname=${HOSTNAME} \
  -v /etc/localtime:/etc/localtime:ro \
  -p 7878:7878 \
  -e PUID=1001 -e PGID=1001 \
  -v ${LOCALDIR}:/config \
  -v ${DOWNLOADS}:/downloads \
  -v ${COMPLETE}:/movies \
  ${IMAGE}:${VERSION}

docker logs ${SERVICE}
