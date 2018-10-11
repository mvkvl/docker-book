#!/usr/bin/env bash

. /opt/scripts/env.sh
if [ $? != 0 ]; then
  echo "influx  ERROR initialization error happened"
  exit 1
fi

wait_for() {
  local HOST=$1
  local PORT=$2
  local TM=$3
  for i in `seq $TM` ; do
    nc -z "$HOST" "$PORT" > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ] ; then
      return 0
    fi
    sleep 1
  done
  return 1
}

EXIT_FLAG=0

exit_script() {
    # trap - SIGINT SIGTERM # clear the trap
    # service chronograf stop
    service influxdb   stop
    echo
    echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "influx  INFO   influxdb container stopped"
    echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo
    EXIT_FLAG=1
}

# set system timezone (if TZ variable is set)
# if [ ! -z "$TZ" ]; then
#   echo "mariadb INFO  set system timezone to $TZ"
#   rm /etc/localtime                            && \
#   ln -s /usr/share/zoneinfo/$TZ /etc/localtime && \
#   echo $TZ > /etc/timezone;
# fi

service influxdb   start

# on first run should initialize database
if [ ! -f /var/lib/influxdb/.initialized ]; then
  if [ -z "$DB_STARTUP_TIMEOUT" ]; then
    DB_STARTUP_TIMEOUT=30
  fi
  echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "influx  INFO   waiting for influxdb to get ready"
  wait_for localhost 8086 $DB_STARTUP_TIMEOUT
  if [ $? -eq 0 ] ; then
    echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "CREATE DATABASE $INFLUX_DATABASE" > /tmp/influx-ddl
    echo "influx  INFO   Creating influx database '$INFLUX_DATABASE'"
    echo "CREATE RETENTION POLICY oneyear ON $INFLUX_DATABASE DURATION 52w REPLICATION 1 SHARD DURATION 4w DEFAULT" >> /tmp/influx-ddl
    if [ -n "$ADMIN_USER" -a -n "$ADMIN_PASSWORD" ]; then
      echo "influx  INFO   Creating admin user '$ADMIN_USER'"
      echo "CREATE USER $ADMIN_USER WITH PASSWORD '$ADMIN_PASSWORD' WITH ALL PRIVILEGES" >> /tmp/influx-ddl
      if [ -n "$WRITER_NAME" -a -n "$WRITER_PASSWORD" ]; then
        echo "influx  INFO   Creating write user '$WRITER_NAME'"
        echo "CREATE USER $WRITER_NAME WITH PASSWORD '$WRITER_PASSWORD'" >> /tmp/influx-ddl
        echo "GRANT WRITE ON $INFLUX_DATABASE TO $WRITER_NAME" >> /tmp/influx-ddl
      fi
      if [ -n "$READER_NAME" -a -n "$READER_PASSWORD" ]; then
       echo "influx  INFO   Creating read  user '$READER_NAME'"
       echo "CREATE USER $READER_NAME WITH PASSWORD '$READER_PASSWORD'" >> /tmp/influx-ddl
       echo "GRANT READ  ON $INFLUX_DATABASE TO $READER_NAME" >> /tmp/influx-ddl
      fi
    fi
    echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    cat /tmp/influx-ddl
    echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    influx -import -path=/tmp/influx-ddl -precision=s
    rm /tmp/influx-ddl
    touch /var/lib/influxdb/.initialized
  else
    # echo "influx  ERROR ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "influx  ERROR  influxdb not available - terminating      "
    echo "influx  ERROR ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    exit 1
  fi
fi

# CREATE RETENTION POLICY oneyear ON monitor DURATION 52w REPLICATION 1 SHARD DURATION 4w DEFAULT


echo
echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "influx  INFO   influxdb container started"
echo "influx  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
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



# create_root_user() {
#   RU=root
#   if [ ! -z "$MYSQL_ROOT_USER" ]; then
#     RU=$MYSQL_ROOT_USER
#   fi
#   RP=root
#   if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
#     RP=$MYSQL_ROOT_PASSWORD
#   fi
#   mysql -u root mysql -e "CREATE USER IF NOT EXISTS '$RU'@'%' IDENTIFIED BY '$RP'; GRANT ALL PRIVILEGES ON *.* TO '$RU'@'%' IDENTIFIED BY '$RP' WITH GRANT OPTION; flush privileges;"
# }
# on first run should configure root user (for remote access)
# if [ ! -f /var/lib/mysql/.initialized ]; then
#   create_root_user
#   mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
#   touch /var/lib/mysql/.initialized
# fi
# service chronograf start
