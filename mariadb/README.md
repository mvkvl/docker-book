# docker-mariadb
MariaDB Docker Image (get it [here](https://hub.docker.com/r/mvkvl/mariadb/))

## General Info
- based on [bitnami/minideb](https://hub.docker.com/r/bitnami/minideb/)
- size is only 290 Mb
- in fact slightly larger then [bitnami/mariadb](https://hub.docker.com/r/bitnami/mariadb/) image, the difference is in initialization and parameters passing
- see details on [GitHub](https://github.com/mvkvl/docker-mariadb)

## Mariadb Configuration
For non-default MariaDB configuration you can attach a directory with configuration files as a volume */etc/mysql/conf.d*.

## Data Persistance
If you want your data to be stored outside the container, you can attach data directory as volume */var/lib/mysql*.

## Database (Re)Initialization
On the first run system database is being initialized with *mysql_install_db* command. After this *.initialized* file is creted in data directory, which prevents the container from database initialization on next runs. If you need to reinitialize database, just remove this file.

## Admin User
Default *root* user has no password set and only allowed to connect from inside docker container (`mysql -u root mysql`). On the first run administrative user is being created with full database management rights and allowed remote access. User name and password can be passed to container via environment variables or secrets.

- MYSQL_ROOT_USER
- MYSQL_ROOT_PASSWORD

## Environment Variables
Environment Variables can be passed to container with following methods:
- docker command ( *-e* switch )
- docker-compose file ( *environment* section )
- as a variable from attached volume ( `host-env-dir:/opt/env:ro` ), here every file is named as EV and contains the value for given EV (see example on [GitHib](https://github.com/mvkvl/docker-mariadb))
- as a docker secret ( only *mysql_root_user* and *mysql_root_password* secrets are supported )
- */opt/scripts/env.sh* script sources all scripts from */opt/env* directory; here you can also set any needed environment variables or perform any additional initialization steps

Supported environment variables are:
- TZ
- MYSQL_ROOT_USER
- MYSQL_ROOT_PASSWORD
