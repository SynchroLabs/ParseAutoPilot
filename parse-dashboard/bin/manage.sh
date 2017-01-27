#!/bin/bash

CONSUL=${CONSUL:-consul}

# ContainerPilot preStart
#
preStart() {
    echo "preStart"
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
