FROM bitnami/minideb
MAINTAINER kami <kami@slink.ws>

COPY ./scripts/run    /opt/scripts/run
COPY ./scripts/env    /opt/scripts/env
COPY ./scripts/env.sh /opt/scripts/env.sh

RUN export DEBIAN_FRONTEND=noninteractive && export LC_ALL=C && apt-get update && apt-get install -y --no-install-recommends mariadb-client mariadb-server && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/mysql/* && sed -i "s|127.0.0.1|0.0.0.0|" /etc/mysql/mariadb.conf.d/50-server.cnf && echo ". /opt/scripts/env.sh" >> /root/.bashrc

CMD ["/opt/scripts/run/entrypoint.sh"]
