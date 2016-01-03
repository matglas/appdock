#!/usr/bin/env bash

docker build --tag matglas/appdock:latest .

echo ""
echo "Build images"
docker images | head -1
docker images | grep appdock

WORKUID=`id -u`
WORKGID=`id -g`
echo ""
echo "Start container from latest build."
RUNID=`docker run -d -e="WORK_UID=$WORKUID" -e="WORK_GID=$WORKGID" appdock:latest`

STARTPID=$!
wait $STARTPID

echo "Run id: $RUNID"
EMPTY=docker ps

#docker exec $RUNID env
#docker exec $RUNID id
#docker exec $RUNID ls -la /root
docker exec $RUNID /root/user-add.sh

echo ""
echo "Running containers"
docker ps

echo ""
echo "Stop container"
docker stop $RUNID

STOPPID=$!
wait $STOPPID

docker wait $RUNID

echo ""
echo "Create new commit"
BUILDID=`docker commit --change="WORKDIR /home/app/src" $RUNID appdock:latest`
echo "Build id: $BUILDID"

BUILDPID=$!
wait $BUILDPID

echo ""
echo "Remove container"
docker rm $RUNID

echo ""
echo "Build images"
docker images | head -1
docker images | grep appdock