#! /bin/bash

docker run -d --rm -p 10080:8888 -v `pwd`/test-app:/service --name test-app mvkvl/uwsgi
