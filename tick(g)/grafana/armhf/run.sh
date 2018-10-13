#!/bin/bash

#grafana-server                                              \
#  --homepath="/usr/share/grafana"                           \
#  --config="/etc/grafana/grafana.ini"                       \
#  "$@"                                                      \
#  cfg:default.log.mode="console"                            \
#  cfg:default.paths.data="/var/lib/grafana"                 \
#  cfg:default.paths.logs="/var/log/grafana"                 \
#  cfg:default.paths.plugins="/var/lib/grafana/plugins"      \
#  cfg:default.paths.provisioning="/etc/grafana/provisioning"


EXIT_FLAG=0

exit_script() {
    service grafana-server stop
    echo
    echo "grafana INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "grafana INFO   grafana container stopped"
    echo "grafana INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo
    EXIT_FLAG=1
}

service grafana-server start

# on first run install plugins
if [ ! -f /var/lib/grafana/.initialized ]; then
  grafana-cli plugins install vonage-status-panel
  grafana-cli plugins install natel-influx-admin-panel
  grafana-cli plugins install jdbranham-diagram-panel
  grafana-cli plugins install raintank-worldping-app
  grafana-cli plugins install petrslavotinek-carpetplot-panel
  touch /var/lib/grafana/.initialized
  service grafana-server restart
fi

echo
echo "grafana INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "grafana INFO   grafana container started"
echo "grafana INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo


#
#  IMPLEMENT "INIT" HERE INSTEAD OF INFINITE LOOP (?)
#
trap exit_script SIGINT
trap exit_script SIGQUIT
trap exit_script SIGABRT
trap exit_script SIGTERM

while [ $EXIT_FLAG == 0 ]; do
  sleep 3
  # #
  # # check running services and restart if needed
  # #
done
