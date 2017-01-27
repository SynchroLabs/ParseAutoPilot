#!/bin/bash

CONSUL=${CONSUL:-consul}

# ContainerPilot preStart
#
preStart() {
    echo "preStart"

    until [[ `curl -s ${CONSUL}:8500/v1/health/state/passing | grep mongodb-replicaset` ]]
    do
        echo "mongodb-replicaset not healthly...."
        sleep 5
    done
}

# ContainerPilot onChange
#
onChange() {
    echo "onChange"
}

until
    cmd=$1
    if [ -z "$cmd" ]; then
        onChange
    fi
    shift 1
    $cmd "$@"
    [ "$?" -ne 127 ]
do
    onChange
    exit
done
