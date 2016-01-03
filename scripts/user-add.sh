#!/bin/bash

addgroup --gid $WORK_GID app

adduser --uid=$WORK_UID --gid=$WORK_GID --disabled-password --gecos "" app && \
  echo "app ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo "Change ownership to app:app on /home/app"
chown -R app:app /home/app

