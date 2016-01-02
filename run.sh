#!/usr/bin/env bash
docker run -u app --rm -t -i -v /home/vhosts/appdock/src:/home/app/src/ appdock:latest
