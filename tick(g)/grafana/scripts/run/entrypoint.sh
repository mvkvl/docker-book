#!/usr/bin/env bash

. /opt/scripts/env.sh
if [ $? != 0 ]; then
  echo "grafana ERROR initialization error happened"
  exit 1
fi

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


# set system timezone (if TZ variable is set)
# if [ ! -z "$TZ" ]; then
#   echo "mariadb INFO  set system timezone to $TZ"
#   rm /etc/localtime                            && \
#   ln -s /usr/share/zoneinfo/$TZ /etc/localtime && \
#   echo $TZ > /etc/timezone;
# fi

#   local HOST=$1
#   local PORT=$2
#   local TM=$3
#   for i in `seq $TM` ; do
#     nc -z "$HOST" "$PORT" > /dev/null 2>&1
#     result=$?
#     if [ $result -eq 0 ] ; then
#       return 0
#     fi
#     sleep 1
#   done
#   return 1
# }

# on first run should initialize database
# if [ ! -f /var/lib/influxdb/.initialized ]; then
#   if [ -z "$DB_STARTUP_TIMEOUT" ]; then
#     DB_STARTUP_TIMEOUT=30
#   fi
#   echo "grafana INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#   echo "grafana INFO   waiting for influxdb to get ready"
#   wait_for localhost 8086 $DB_STARTUP_TIMEOUT
#   if [ $? -eq 0 ] ; then
#     echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     echo "CREATE DATABASE $INFLUX_DATABASE" > /tmp/influx-ddl
#     echo "influx  INFO   Creating influx database '$INFLUX_DATABASE'"
#     echo "CREATE RETENTION POLICY oneyear ON $INFLUX_DATABASE DURATION 52w REPLICATION 1 SHARD DURATION 4w DEFAULT" >> /tmp/influx-ddl
#     if [ -n "$ADMIN_USER" -a -n "$ADMIN_PASSWORD" ]; then
#       echo "influx  INFO   Creating admin user '$ADMIN_USER'"
#       echo "CREATE USER $ADMIN_USER WITH PASSWORD '$ADMIN_PASSWORD' WITH ALL PRIVILEGES" >> /tmp/influx-ddl
#       if [ -n "$WRITER_NAME" -a -n "$WRITER_PASSWORD" ]; then
#         echo "influx  INFO   Creating write user '$WRITER_NAME'"
#         echo "CREATE USER $WRITER_NAME WITH PASSWORD '$WRITER_PASSWORD'" >> /tmp/influx-ddl
#         echo "GRANT WRITE ON $INFLUX_DATABASE TO $WRITER_NAME" >> /tmp/influx-ddl
#       fi
#       if [ -n "$READER_NAME" -a -n "$READER_PASSWORD" ]; then
#        echo "influx  INFO   Creating read  user '$READER_NAME'"
#        echo "CREATE USER $READER_NAME WITH PASSWORD '$READER_PASSWORD'" >> /tmp/influx-ddl
#        echo "GRANT READ  ON $INFLUX_DATABASE TO $READER_NAME" >> /tmp/influx-ddl
#       fi
#     fi
#     echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     cat /tmp/influx-ddl
#     echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     influx -import -path=/tmp/influx-ddl -precision=s
#     rm /tmp/influx-ddl
#     touch /var/lib/influxdb/.initialized
#   else
#     # echo "influx  ERROR ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     echo "influx  ERROR  influxdb not available - terminating      "
#     echo "influx  ERROR ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#     exit 1
#   fi
# fi

# CREATE RETENTION POLICY oneyear ON monitor DURATION 52w REPLICATION 1 SHARD DURATION 4w DEFAULT
