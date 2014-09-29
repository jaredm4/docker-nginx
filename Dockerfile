# VERSION: 2.1
# DOCKER-VERSION: 1.2.0
# AUTHOR: Jared Markell <jaredm4@gmail.com>
# TO_RUN: docker run -d -p 80:80 -v <sites-enabled-dir>:/etc/nginx/sites-enabled -v <log-dir>:/var/log/nginx shopigniter/nginx
#
# Sample nginx config here:
# https://github.com/dotcloud/docker-registry/blob/master/contrib/nginx.conf
# Additional sample configs here:
# https://github.com/dotcloud/docker-registry/issues/82
# CHANGELOG:
# 2.1   Upgrade to Ubuntu:14.04. Removed Volume for logs.
# 2.0   Upgrade to Ubuntu 13.10 and Nginx 1.4
# 1.2   Volume'd the /var/log directory entirely.
# 1.1   Added local and home, re-built on Docker 0.8.1
# 1.0   Inspired by http://dockerfile.github.io/#/nginx

FROM ubuntu:14.04

MAINTAINER Jared Markell, jaredm4@gmail.com

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Setup deps and install Nginx
RUN apt-get update &&\
    apt-get -y install curl git unzip vim ruby nginx-extras &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Setup nginx to work in foreground
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80
ENTRYPOINT ["nginx"]
