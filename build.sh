#!/bin/sh

set -x

IMAGE_NAME="archlinuxarm-yay"
VERSION="aarch64"

TEMPFILE="$(mktemp)"

docker pull dasbaumwolltier/archlinuxarm:aarch64
docker build . > $TEMPFILE

IMAGE_ID="$(cat "$TEMPFILE" | tail -1 | cut -d' ' -f3 | tr ' ' '\n')"

set +x
echo $HUB_PASS | docker login --username "$HUB_USER" --password-stdin
set -x

docker tag "$IMAGE_ID" "dasbaumwolltier/$IMAGE_NAME:$VERSION"
docker push "dasbaumwolltier/$IMAGE_NAME:$VERSION"

if [ $VERSION != "latest" ]; then
    docker tag "$IMAGE_ID" "dasbaumwolltier/$IMAGE_NAME:latest"
    docker push "dasbaumwolltier/$IMAGE_NAME:latest"
fi

docker logout 