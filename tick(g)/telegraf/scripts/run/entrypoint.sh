#!/usr/bin/env bash

. /opt/scripts/env.sh
if [ $? != 0 ]; then
  echo "chrono ERROR initialization error happened"
  exit 1
fi

EXIT_FLAG=0

exit_script() {
    # trap - SIGINT SIGTERM # clear the trap
    service chronograf stop
    echo
    echo "chrono  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "chrono  INFO   chronograf container stopped"
    echo "chrono  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
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

# on first run should initialize database
# if [ ! -f /var/lib/mysql/.initialized ]; then
#   mysql_install_db
# fi


# service mysql start
# sudo systemctl start influxdb

# on first run should configure root user (for remote access)
# if [ ! -f /var/lib/mysql/.initialized ]; then
#   create_root_user
#   mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
#   touch /var/lib/mysql/.initialized
# fi

service chronograf start

echo
echo "chrono  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "chrono  INFO   chronograf container started"
echo "chrono  INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
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
