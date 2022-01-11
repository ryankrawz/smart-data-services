#!/bin/bash

source ./buildtools.sh


docker tag $DOCKER_LOCAL_REPOSITORY:latest $IMAGE_NAME

docker push $IMAGE_NAME
