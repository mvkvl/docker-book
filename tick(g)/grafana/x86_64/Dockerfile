FROM bitnami/minideb
MAINTAINER kami <kami@slink.ws>

COPY ./scripts/run    /opt/scripts/run
COPY ./scripts/env    /opt/scripts/env
COPY ./scripts/env.sh /opt/scripts/env.sh

ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
RUN export DEBIAN_FRONTEND=noninteractive && export LC_ALL=C                               && \
           \
           install_packages wget openssl gnupg2 ca-certificates apt-transport-https        && \
           \
           wget https://packagecloud.io/gpg.key -O /tmp/grafana-gpg.key                    && \
           apt-key add /tmp/grafana-gpg.key                                                && \
           echo "deb https://packagecloud.io/grafana/stable/debian/ stretch main" |           \
                                                  tee /etc/apt/sources.list.d/grafana.list && \
           apt-get update                                                                  && \
           \
           apt-get remove -y curl wget openssl gnupg2 ca-certificates                      && \
           apt-get autoremove -y                                                           && \
           apt-get -y --no-install-recommends install grafana                              && \
           apt-get clean && rm -rf /var/lib/apt/lists/* && rm /tmp/grafana-gpg.key

CMD ["/opt/scripts/run/entrypoint.sh"]
