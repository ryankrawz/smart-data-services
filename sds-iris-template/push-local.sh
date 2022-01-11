#!/bin/bash

source ./buildtools.sh

docker push $LOCAL_IMAGE_NAME
exit_if_error "Could not push $LOCAL_IMAGE_NAME to local registry."