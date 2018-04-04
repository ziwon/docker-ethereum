#!/usr/bin/env bash

. $(dirname "$0")/__VARS__

RUN=${RUN:-$1} && shift

echo ">> Executing ${RUN}"
container=`docker ps -q --filter=ancestor=${IMAGE_NAME}${TAG}`
if [ -n "$container" ]; then
    docker exec -it $container $RUN
else
    echo ">> No container: ${IMAGE_NAME}${TAG}"
fi

[ ! $? -eq 0 ] && { echo ">> Error occured while doing labs: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."
