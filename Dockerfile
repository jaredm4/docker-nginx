# VERSION: 1.2
# DOCKER-VERSION: 0.8.1
# AUTHOR: Jared Markell <jaredm4@gmail.com>
# TO_RUN: docker run -d -p 80:80 -v <sites-enabled-dir>:/etc/nginx/sites-enabled -v <log-dir>:/var/log/nginx shopigniter/nginx
#
# Inspired by dockerfile/nginx but modified to include nginx-extras, needed by Docker Registry.
# http://dockerfile.github.io/#/nginx
# In order to get the Chunkin module for nginx, we have to use the stable version 1.2.1.
#
# Sample nginx config here:
# https://github.com/dotcloud/docker-registry/blob/master/contrib/nginx.conf
# Additional sample configs here:
# https://github.com/dotcloud/docker-registry/issues/82
# CHANGELOG:
# 1.2 Volume'd the /var/log directory entirely.
# 1.1 Added local and home, re-built on Docker 0.8.1

FROM ubuntu:12.10

MAINTAINER Jared Markell, jaredm4@gmail.com

# Setup locale and home - helps when using bash
RUN locale-gen en_US
ENV HOME /root

# Setup deps and install Nginx
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common &&\
    add-apt-repository -y ppa:nginx/stable &&\
    apt-get update &&\
    apt-get upgrade -y &&\
    apt-get -y install curl git unzip vim ruby nginx-common=1.2.1-2.2 nginx-extras=1.2.1-2.2 &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Setup nginx to work in foreground
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

VOLUME ["/var/log"]

EXPOSE 80
ENTRYPOINT ["nginx"]
