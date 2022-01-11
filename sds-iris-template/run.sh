#!/bin/bash
#
# This script is just to test the IRIS image outside of Kubernetes
#

source ./buildtools.sh

docker run --rm -it --name sds_iris_template \
    -p 1972:1972 -p 52773:52773 \
    -v $PWD/license:/external/license \
    $LOCAL_IMAGE_NAME --key /external/license/iris.key