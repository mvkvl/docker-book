#!/usr/bin/env bash

. /opt/scripts/env.sh
if [ $? != 0 ]; then
  echo "mariadb ERROR initialization error happened"
  exit 1
fi

EXIT_FLAG=0

create_root_user() {
  RU=root
  if [ ! -z "$MYSQL_ROOT_USER" ]; then
    RU=$MYSQL_ROOT_USER
  fi
  RP=root
  if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    RP=$MYSQL_ROOT_PASSWORD
  fi
  mysql -u root mysql -e "CREATE USER IF NOT EXISTS '$RU'@'%' IDENTIFIED BY '$RP'; GRANT ALL PRIVILEGES ON *.* TO '$RU'@'%' IDENTIFIED BY '$RP' WITH GRANT OPTION; flush privileges;"
}

exit_script() {
    # trap - SIGINT SIGTERM # clear the trap
    service mysql stop
    echo
    echo "mariadb INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "mariadb INFO   mariadb container stopped"
    echo "mariadb INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo
    EXIT_FLAG=1
}

# set system timezone (if TZ variable is set)
if [ ! -z "$TZ" ]; then
  echo "mariadb INFO  set system timezone to $TZ"
  rm /etc/localtime                            && \
  ln -s /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone;
fi

# on first run should initialize database
if [ ! -f /var/lib/mysql/.initialized ]; then
  mysql_install_db
fi


service mysql start

# on first run should configure root user (for remote access)
if [ ! -f /var/lib/mysql/.initialized ]; then
  create_root_user
  mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
  touch /var/lib/mysql/.initialized
fi

echo
echo "mariadb INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "mariadb INFO   mariadb container started"
echo "mariadb INFO  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo

#
#  IMPLEMENT "INIT" HERE INSTEAD OF INFINITE LOOP (?)
#
trap exit_script SIGINT
trap exit_script SIGQUIT
trap exit_script SIGABRT
trap exit_script SIGTERM

while [ $EXIT_FLAG == 0 ]; do
  sleep 1
  # #
  # # check running services and restart if needed
  # #
done
