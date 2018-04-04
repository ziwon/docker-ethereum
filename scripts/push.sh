#!/usr/bin/env bash

. $(dirname "$0")/__VARS__

echo ">> Log in to Docker Hub"
docker login --username=$DOCKER_USER

echo ">> Pushing"
CMD="docker push ${IMAGE_NAME}${TAG}"
echo ">> $CMD" && $CMD

[ ! $? -eq 0 ] && { echo ">> Error occured while pushing: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."
