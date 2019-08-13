FROM lsiobase/mono:amd64-xenial-5.14
MAINTAINER sparklyballs

# environment settings
ENV XDG_CONFIG_HOME="/config/xdg"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install radarr
RUN \
  RADARR_DL_URL=$(curl -sX GET "https://api.github.com/repos/Radarr/Radarr/releases" | grep browser_download_url | head -n5 | grep linux | head -n1 | awk '{print $NF}' | xargs) ; \
 mkdir -p \
	/opt/radarr && \
 curl -o \
 /tmp/radar.tar.gz -L \
	"${RADARR_DL_URL}" && \
 tar ixzf \
 /tmp/radar.tar.gz -C \
	/opt/radarr --strip-components=1 && \

# clean up
 rm -rf \
	/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 8903
VOLUME /config /downloads /movies
