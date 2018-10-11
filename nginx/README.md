# docker-nginx
Nginx Docker Image (get it [here](https://hub.docker.com/r/mvkvl/nginx/))

## General Info
- based on [bitnami/minideb](https://hub.docker.com/r/bitnami/minideb/)
- size is 107 Mb
- uses [apt-cacher](https://github.com/mvkvl/docker-book/tree/master/apt-cacher) for build

## Example Docker Compose File
```
version: '3.1'
services:
  nginx:
    container_name: nginx
    hostname: nginx
    image: mvkvl/nginx
    volumes:
        - nginx.conf:/etc/nginx/nginx.conf:ro
        - site.conf:/etc/nginx/sites-enabled/site.conf:ro
    ports:
      - '10080:80'
    stdin_open: true
    tty: true
```
