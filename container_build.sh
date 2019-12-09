#!/bin/bash
export FILEBEAT_TAG_VERSION=1.0.1

if [ -z $1 ]; then
    echo -e "Available options:
        * build
        * push
    "
elif [ "$1" == "build" ]; then
    docker-compose -f docker-compose-build.yml build
elif [ "$1" == "push" ]; then
    docker-compose -f docker-compose-build.yml push
else
    echo $1 ": command not found"
    echo -e "Available options:
        * build
        * push
    "
fi