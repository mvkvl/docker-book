# docker-nginx
apt-cacher Docker Image (get it [here](https://hub.docker.com/r/mvkvl/apt-cacher/))

## General Info
- based on [bitnami/minideb](https://hub.docker.com/r/bitnami/minideb/)
- size is only 78 Mb

## Example Docker Compose File
```
version: '3.1'
services:
  apt-cacher:
    container_name: apt-cacher
    hostname: apt-cacher
    image: mvkvl/apt-cacher
    ports:
      - '3142:3142'
    stdin_open: true
    tty: true
```
