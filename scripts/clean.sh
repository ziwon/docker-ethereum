#!/usr/bin/env bash

. $(dirname "$0")/__VARS__

echo ">> Stopping and Cleaning containers"
containers=`docker ps -qa --filter=ancestor=${IMAGE_NAME}${TAG}`
if [ -n "$containers" ]; then
    docker stop $containers
    docker rm -f $containers
else
    echo ">> No containers to clean: ${IMAGE_NAME}${TAG}"
fi

echo ">> Cleaning images"
images=`docker images --format "{{.ID}}: {{.Repository}}:{{.Tag}}" | grep "${IMAGE_NAME}${TAG}" | cut -c1-12`
if [ -n "$images" ]; then
    docker rmi -f $images
else
    echo ">> No images to clean: ${IMAGE_NAME}${TAG}"
fi

[ ! $? -eq 0 ] && { echo ">> Error occured while cleaning: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."