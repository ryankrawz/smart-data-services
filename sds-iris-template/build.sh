#!/bin/bash

source ./buildtools.sh

docker build --force-rm -t $IMAGE_NAME .
exit_if_error "Could not build the image $IMAGE_NAME"

docker tag $IMAGE_NAME $LOCAL_IMAGE_NAME
exit_if_error "Could not tag the image $IMAGE_NAME as $LOCAL_IMAGE_NAME"
