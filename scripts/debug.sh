#!/usr/bin/env bash

. $(dirname "$0")/__VARS__

COMMAND=${COMMAND:-$1} && shift

echo ">> Getting COMMAND into a container"
container=`docker ps -q --filter=ancestor=${IMAGE_NAME}${TAG}`
if [ -n "$container" ]; then
    CMD="docker exec -it $container $COMMAND"
	echo $CMD && $CMD
else
    echo ">> No container: ${IMAGE_NAME}${TAG}"
fi

[ ! $? -eq 0 ] && { echo ">> Error occured while debugging: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."
