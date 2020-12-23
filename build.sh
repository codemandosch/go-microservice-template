#!/usr/bin/env sh

# Abort on any non-zero exitcode
set -e
DOCKER_REGISTRY="eu.gcr.io"
PROJECT_NAME="changeme"
BIN_NAME="changeme"

finish () {
    if [ $DONE = "true" ]
    then
        echo "Build done successfully, exiting"
    else
        echo "Build has exited with errors, aborting"
    fi
}
trap finish EXIT

export DONE="false"

echo "Building docker image"
docker build -f Dockerfile -t $DOCKER_REGISTRY/$PROJECT_NAME/$BIN_NAME .

# echo "Pushing docker image"
docker push $DOCKER_REGISTRY/$PROJECT_NAME/$BIN_NAME

DONE="true"
