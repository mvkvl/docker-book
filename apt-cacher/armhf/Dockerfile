#
# Build: docker build -t mvkvl/apt-cacher-armhf .
# Run: docker run --rm -d -p 3142:3142 --name apt-cacher mvkvl/apt-cacher-armhf
#
# and then you can run containers with:
#   docker run -t -i --rm -e http_proxy http://dockerhost:3142/ debian bash
#
# Here, `dockerhost` is the IP address or FQDN of a host running the Docker daemon
# which acts as an APT proxy server.

ARG RELEASE=stretch
FROM arm32v7/debian:${RELEASE}-slim
MAINTAINER kami <kami@slink.ws>

ENV DEBIAN_FRONTEND noninteractive

VOLUME  ["/var/cache/apt-cacher-ng"]
RUN     apt-get update && apt-get install -y apt-cacher-ng net-tools
EXPOSE  3142
CMD     chmod 777 /var/cache/apt-cacher-ng && \
        /etc/init.d/apt-cacher-ng start    && \
        tail -f /var/log/apt-cacher-ng/*
