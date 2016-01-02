#!/usr/bin/env bash

docker build --tag appdock:latest .

WORKUID=`id -u`
WORKGID=`id -g`
docker run -e="WORK_UID=$WORKUID" -e="WORK_GID=$WORKGID" appdock:latest /root/user-add.sh

BUILDID=`docker ps -l -q`
docker commit $BUILDID --change="WORKDIR /home/app/src" appdock:latest

docker rm $BUILDID
docker rm `docker ps -l -q`
