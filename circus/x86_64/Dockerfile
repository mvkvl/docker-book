FROM bitnami/minideb
MAINTAINER kami <kami@slink.ws>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

ARG http_proxy=http://host.docker.internal:3142

RUN \
  apt-get update && apt-get -y upgrade                                && \
  apt-get install -y --no-install-recommends python3 python3-pip         \
                                             python3-setuptools          \
                                             libpython3.5             && \
  apt-get install -y --no-install-recommends gcc python3.5-dev        && \
  pip3 install wheel && pip3 install circus                           && \
  apt-get remove -y gcc python3.5-dev                                 && \
  apt-get autoremove -y                                               && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN \
#  useradd -m -s /bin/bash -p wsgi wsgi

# supervisor base configuration
# ADD circus.conf /etc/circus.conf

CMD ["circusd", "/etc/circus.conf"]
