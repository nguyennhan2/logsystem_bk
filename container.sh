#!/bin/bash
export REPO_NAME=logsystem_bk

if [ -z $1 ]; then
    echo -e "Available options:
        * init
        * start
        * stop
        * status
        * restart
        * ssh
        * logs
        * down
        * down-all
    "
elif [ "$1" == "init" ]; then
    echo "Build..."
    docker-compose up -d --build --scale elasticsearch_slave=0
elif [ "$1" == "start" ]; then
    docker-compose start
elif [ "$1" == "stop" ]; then
    docker-compose stop
elif [ "$1" == "status" ]; then
    docker-compose ps
elif [ "$1" == "down" ]; then
    docker-compose down -v
    docker image prune -f
    echo "Remove  logs"
    find . -path "*Logs/*/*" ! -name ".init" -exec rm -rf {} \;
elif [ "$1" == "down-all" ]; then
    docker-compose down -v --rmi all --remove-orphans
    docker image prune -f
elif [ "$1" == "restart" ]; then
    docker-compose restart
elif [ "$1" == "ssh" ]; then
    if [ -z $2 ]; then
        echo -e "Missing container name"
    else
        docker exec -it $2 /bin/bash 
    fi
elif [ "$1" == "logs" ]; then
    if [ -z $2 ]; then
        docker-compose logs -f
    else
        docker-compose logs -f $2
    fi
else
    echo $1 ": command not found"
    echo -e "Available options:
        * init
        * start
        * stop
        * status
        * restart
        * ssh
        * logs
        * down
        * down-all
    "
fi
