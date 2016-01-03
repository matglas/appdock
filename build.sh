#!/usr/bin/env bash

docker build --tag matglas/appdock:latest .

echo ""
echo "Build images"
docker images | head -1
docker images | grep appdock

WORKUID=`id -u`
WORKGID=`id -g`

docker build --build-arg WORK_UID=$WORKUID --build-arg WORK_GID=$WORKGID --tag local/appdock:latest ./OwnAppDock