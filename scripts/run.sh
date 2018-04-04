#!/usr/bin/env bash

. $(dirname "$0")/__VARS__

ENTRYPOINT=${ENTRYPOINT:-$1} && shift

echo ">> Running"
CMD="docker run --entrypoint ${ENTRYPOINT} -it --rm --name docker-ethereum ${IMAGE_NAME}${TAG} $@"
echo ">> $CMD" && $CMD

[ ! $? -eq 0 ] && { echo ">> Error occured while running: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."
