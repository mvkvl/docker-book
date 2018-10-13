ARG RELEASE=stretch

FROM arm32v7/debian:${RELEASE}-slim

MAINTAINER kami <kami@slink.ws>

ARG GVER=5.2.4

# https://grafana.com/grafana/download/5.2.0-beta1?platform=arm

ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

RUN export DEBIAN_FRONTEND=noninteractive && export LC_ALL=C && \
    apt-get update       && \
    apt-get install -y wget libfontconfig && \
    wget -q https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${GVER}_armhf.deb && \
    dpkg -i grafana_${GVER}_armhf.deb && rm grafana_${GVER}_armhf.deb && \
    apt-get remove -y wget && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./run.sh /run.sh

CMD [ "/run.sh" ]

#    apt-get install -y net-tools          && \
