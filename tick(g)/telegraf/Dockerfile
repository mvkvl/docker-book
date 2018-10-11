FROM bitnami/minideb
MAINTAINER kami <kami@slink.ws>

COPY ./scripts/run    /opt/scripts/run
COPY ./scripts/env    /opt/scripts/env
COPY ./scripts/env.sh /opt/scripts/env.sh

ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
RUN export DEBIAN_FRONTEND=noninteractive && export LC_ALL=C                               && \
           install_packages wget openssl gnupg2 ca-certificates apt-transport-https        && \
           wget https://dl.influxdata.com/chronograf/releases/chronograf_nightly_amd64.deb && \
           dpkg -i chronograf_nightly_amd64.deb && rm chronograf_nightly_amd64.deb         && \
           apt-get remove -y wget openssl gnupg2 ca-certificates apt-transport-https       && \
           apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/opt/scripts/run/entrypoint.sh"]

# CMD ["service", "chronograf", "start"]
# CMD ["influxd", "-config", "/etc/influxdb.conf"]
# CMD ["service", "influxdb", "start"]





# /bin/bash -c "source /etc/os-release"                                     && \
#          #                          && \
#           # systemctl start influxdb
#            # test $VERSION_ID = "7" && echo "deb https://repos.influxdata.com/debian wheezy stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
#            # test $VERSION_ID = "8" && echo "deb https://repos.influxdata.com/debian jessie stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
#            # apt-get install -y --no-install-recommends mariadb-client mariadb-server && \
#
#            # sed -i "s|127.0.0.1|0.0.0.0|" /etc/mysql/mariadb.conf.d/50-server.cnf    && \
#            # echo ". /opt/scripts/env.sh" >> /root/.bashrc
#
# #           curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
# #           source /etc/lsb-release
# #           echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
#
#
# #           curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
# #           source /etc/os-release
#
# #           test $VERSION_ID = "7" && echo "deb https://repos.influxdata.com/debian wheezy stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
# #           test $VERSION_ID = "8" && echo "deb https://repos.influxdata.com/debian jessie stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
# #           test $VERSION_ID = "9" && echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
#
