#! /usr/bin/env bash

usage()
{
    # Display Usage
   echo "Starts the docker image specified with SSH passthrough, X11 passthrough, and a specified image ID."
   echo
   echo "Syntax: hexacopter-env [-p|i|h]"
   echo "options:"
   echo "p     Specify absolute or relative path to ROS2 workspace directory"
   echo "i     Specify docker image ID by local sha256 (e.g. d1165f221234), or dockerhub namespace/tag (e.g. user/repo:tag)"
   echo "h     Print this Help."
   echo
}

while getopts p:i:h flag
do
    case "${flag}" in
    p) 
        path=${OPTARG};;
    i)
        id=${OPTARG};;
    h) 
        usage
        exit;;
    esac
done

if [ -z "$path" ]
then
   echo "Insufficient Arguments: missing 'path' option"
   echo
   usage
   exit
elif [ -z "$id" ]
then
   echo "Insufficient Arguments: missing 'ID' option"
   echo
   usage
   exit
fi

xhost +

docker run -it --rm --privileged --network=host -e DISPLAY=host.docker.internal:0.0   -e LIBGL_ALWAYS_INDIRECT=0 -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.ssh:/home/ubuntu/.ssh -v $path:/home/ubuntu/hexacopter $id bash