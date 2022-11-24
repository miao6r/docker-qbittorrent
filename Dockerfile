FROM debian:bullseye

# set version label
ARG VERSION="4.3.9"
ARG S6_OVERLAY_VERSION=3.1.2.1
ARG QBITTORRENT_VERSION="4.3.9"
ARG QBT_VERSION
LABEL build_version="version:- ${VERSION}"
LABEL maintainer="lucislu"

# environment settings
ARG UNRAR_VERSION=6.1.7
ENV ENV S6_CMD_WAIT_FOR_SERVICES_MAXTIME="120000"
ENV HOME="/config" \
XDG_CONFIG_HOME="/config" \
XDG_DATA_HOME="/config"


# install s6-overlay
RUN apt-get update && apt-get install -y xz-utils netcat

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz
ENTRYPOINT ["/init"]

ADD https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-${QBITTORRENT_VERSION}_v2.0.5/x86_64-icu-qbittorrent-nox /tmp
RUN cp /tmp/x86_64-icu-qbittorrent-nox /usr/bin/qbittorrent-nox && chmod +rx /usr/bin/qbittorrent-nox

# add local files
COPY root/ /
