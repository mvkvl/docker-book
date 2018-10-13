Circus (a Docker image)
===========================


Available on Docker.hub for [x86_64](https://index.docker.io/mvkvl/circus) or
[Raspberry Pi](https://index.docker.io/mvkvl/circus-armhf)


Circus is a linux process manager ([Supervisor website](http://supervisord.org/ "Supervisor website")). It allows us to start containers with e.g.
- multiple processes
- a deamon / background process
- launch groups of processes in a specific order
- and more advanced stuff


# This image is intended to be built on and is the base image for all recipes in [this project](https://github.com/Krijger/docker-cookbooks). Therefore, a child Dockerfile should not have to upgrade ubuntu.

# To make easy use of supervisor, an inheriting Docker project should contain one or more files `[SOME_NAME].conf` and add those to /etc/supervisor/conf.d in the Dockerfile. Note that you can find examples of such files in this repositories projects. Personally, I name all my supervisor configuration file [SERVICE].sv.conf for clarity.

# To run supervisor, you can add `CMD supervisord -c /etc/supervisor.conf`.
