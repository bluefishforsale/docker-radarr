#!/usr/bin/env bash

SERVICE="radarr"
IMAGE="bluefishforsale/radarr"
VERSION="latest"
LOCALDIR="/data01/services/${SERVICE}"
DOWNLOADS="/data01/incoming/movies"
COMPLETE="/data01/complete/movies"

docker stop ${SERVICE}
docker rm ${SERVICE}

docker images | egrep "${IMAGE}\ *${VERSION}" | awk '{print $3}' | xargs docker rmi


sudo docker run -d \
  --cpus=2 \
  --restart=always \
  --name=${SERVICE} \
  --hostname=${HOSTNAME} \
  -v /etc/localtime:/etc/localtime:ro \
  -p 8903:8903 \
  -e PUID=1001 -e PGID=1001 \
  -v ${LOCALDIR}:/config \
  -v ${DOWNLOADS}:/downloads \
  -v ${COMPLETE}:/movies \
  ${IMAGE}:${VERSION}

docker logs ${SERVICE}
