#!/bin/bash

RED="\033[1;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

exit_if_error() {
	if [ $(($(echo "${PIPESTATUS[@]}" | tr -s ' ' +))) -ne 0 ]; then
		if [ ! -z "$1" ];
		then
			echo ""
			echo -e "${RED}ERROR: ${1}$RESET"
			echo ""
		fi
		exit 1
	fi
}

exit_with_error() {
	echo ""
	echo -e "${RED}ERROR: ${1}$RESET"
	echo ""
	exit 1
}

GIT_REPO_NAME=sds_iris_template

TAG=$(cat ./VERSION)
exit_if_error "VERSION file does not exist."

LOCAL_REGISTRY=local-registry:5000
LOCAL_IMAGE_NAME=$LOCAL_REGISTRY/$GIT_REPO_NAME:$TAG


DOCKER_LOCAL_REPOSITORY=local-registry:5000/$GIT_REPO_NAME
IMAGE_NAME=containers.intersystems.com/iscinternal/sds/$GIT_REPO_NAME:$TAG