>>!/usr/bin/env bash

. $(dirname "$0")/__VARS__

echo ">> Building"
CMD="docker build -t ${IMAGE_NAME}${TAG} ."
echo ">> $CMD" && $CMD

[ ! $? -eq 0 ] && { echo ">> Error occured while building: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."
