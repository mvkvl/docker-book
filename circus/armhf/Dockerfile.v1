ARG RELEASE=stretch

FROM arm32v7/debian:${RELEASE}-slim
MAINTAINER kami <kami@slink.ws>

# ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
# ARG http_proxy=http://"$(hostname -I | awk '{print $1}')":3142
# ARG http_proxy=http://192.168.2.101:3142

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

RUN \
  apt-get update && apt-get -y upgrade                                && \
  apt-get install -y --no-install-recommends python3 python3-pip         \
                                             python3-setuptools          \
                                             libpython3.5             && \
  apt-get install -y --no-install-recommends gcc python3.5-dev        && \
  apt-get install -y --no-install-recommends libzmq3-dev              && \
  pip3 install wheel && pip3 install circus                           && \
  apt-get remove -y gcc python3.5-dev                                 && \
  apt-get autoremove -y                                               && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN \
#  useradd -m -s /bin/bash -p service service

# supervisor base configuration
# ADD circus.conf /etc/circus.conf

CMD ["circusd", "/etc/circus.conf"]
