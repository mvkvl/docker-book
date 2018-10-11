uWSGI (Docker image)
===========================
uWSGI Docker Image (get it [here](https://hub.docker.com/r/mvkvl/uwsgi/))

## General Info
- Based on [bitnami/minideb](https://hub.docker.com/r/bitnami/minideb/).
- size is 146 Mb
- uses [apt-cacher](https://github.com/mvkvl/docker-book/tree/master/apt-cacher) for build

## Attaching application
To attach an application intended to be served by this image, use --volume feature of docker or
docker-compose. Application directory should be mounted to '/service' directory on container's file system.


## wsgi.py
Entry point should be in wsgi.py. Also 'application' runnable object should be declared in wsgi.py.
```
from app import application
if __name__ == "__main__":
    application.run()
```

## uWSGI configuration
Deafult uWSGI configuration is following:
```
[uwsgi]
chdir              = /service
module             = wsgi:application
socket             = :8888
protocol           = http
enable-threads     = true
single-interpreter = true
vacuum             = true
die-on-term        = true
master             = true
processes          = 5
threads            = 2
uid                = wsgi
```

To use your own config, attach it as a volume to '/etc/uwsgi.conf'.

## Circus
[Circus](https://circus.readthedocs.io/en/latest/) manages uwsgi process in this image.
Its configuration is located in /etc/circus.conf.
```
[circus]
endpoint        = tcp://127.0.0.1:5555
pubsub_endpoint = tcp://127.0.0.1:5556
stats_endpoint  = tcp://127.0.0.1:5557

[watcher:service]
cmd             = /usr/local/bin/uwsgi --ini /etc/uwsgi.conf
send_hup        = True
stop_signal     = QUIT
warmup_delay    = 0
```
To start several uwsgi applications create and attach custom circus config:
```
[watcher:service_01]
cmd             = /usr/local/bin/uwsgi --ini /etc/uwsgi_01.conf
send_hup        = True

[watcher:service_02]
cmd             = /usr/local/bin/uwsgi --ini /etc/uwsgi_02.conf
send_hup        = True
```

## Example Docker Compose File
```
version: '3.6'
services:
  test-app:
    build: .
    container_name: test-app
    hostname: test-app
    image: mvkvl/uwsgi
    volumes:
      - ./test-app:/service
    ports:
      - 10080:8888
    stdin_open: true
    tty: true
```
