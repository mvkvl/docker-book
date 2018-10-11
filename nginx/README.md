# docker-nginx
Nginx Docker Image (get it [here](https://hub.docker.com/r/mvkvl/nginx/))

## General Info
- based on [bitnami/minideb](https://hub.docker.com/r/bitnami/minideb/)
- size is only 107 Mb
- uses [apt-cacher] to increase building time

## Example Docker Compose File
```
version: '3.1'
services:
  nginx:
    container_name: nginx
    hostname: nginx
    image: mvkvl/nginx
#    volumes:
#        - ./container/mariadb/conf:/etc/mysql/conf.d:ro
    ports:
      - '10080:80'
    stdin_open: true
    tty: true
```
