#!/bin/bash

#
# env expand:
# https://gist.github.com/bvis/b78c1e0841cfd2437f03e20c1ee059fe
#

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  E X P O R T   S E C R E T S
#
# (will override values passed as
#  ENV to container or configured
#  in /opt/env)
#
if [ -f "/run/secrets/mysql_root_user" ]; then
  export MYSQL_ROOT_USER=`cat /run/secrets/mysql_root_user | tr -d '\n'`
fi
if [ -f "/run/secrets/mysql_root_password" ]; then
  export MYSQL_ROOT_PASSWORD=`cat /run/secrets/mysql_root_password | tr -d '\n'`
fi
