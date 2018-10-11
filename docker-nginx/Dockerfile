#
# Build: docker build -t mvkvl/nginx .
# Run: docker run --rm -d -p 10080:80 --name nginx mvkvl/nginx
#

FROM bitnami/minideb
MAINTAINER kami <kami@slink.ws>

ARG http_proxy=http://host.docker.internal:3142

RUN export DEBIAN_FRONTEND=noninteractive                                   && \
      apt-get update                                                        && \
      apt-get install --no-install-recommends -y -q nginx                   && \
      apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]
