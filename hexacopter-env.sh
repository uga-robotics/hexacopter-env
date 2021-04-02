#! /usr/bin/env bash

WORKSPACE=$1

docker run -it --rm --network=host -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.ssh:/home/ubuntu/.ssh -v ${WORKSPACE}:/home/ubuntu/hexacopter a95245d327da bash
