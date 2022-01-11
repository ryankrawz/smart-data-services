#!/bin/bash

source ./buildtools.sh

SERVICE_NAME=sds-iris-service

ping local-registry -c 1
if [ ! $? -eq 0 ]; 
then
    printf "\nYour /etc/hosts is not configured properly. Add the following line to it and run this script again:"
    printf "\n\n\t127.0.0.1 local-registry"
    printf "\n\n"
    printf "If you are running on windows:\n"
    printf "\t- this script must be run as an administrator"
    printf "\t- your hosts file is at C:\\Windows\\System32\\drivers\\etc\\hosts\n\n"

else
    printf "\n\nDELETING PVCs...\n\n"
    # IKO is not eliminating the PVC when the deployment is deleted
    # so we must do it ourselves if we want the new deployment to use the new code from the new image
    kubectl delete pvc iris-data-$SERVICE_NAME-data-0 -n $SERVICE_NAME
    kubectl delete pvc iris-journal1-$SERVICE_NAME-data-0 -n $SERVICE_NAME
    kubectl delete pvc iris-journal2-$SERVICE_NAME-data-0 -n $SERVICE_NAME
    kubectl delete pvc iris-wij-$SERVICE_NAME-data-0 -n $SERVICE_NAME

    printf "\n\nSKAFFOLD BUILD...\n\n"
    skaffold build --default-repo local-registry:5000
    exit_if_error "A problem occurred while trying to build the images."

    printf "\nCreating $SERVICE_NAME namespace"
	kubectl create namespace "$SERVICE_NAME"
	exit_if_error "\nCould not create $SERVICE_NAME namespace"
    
    skaffold dev --port-forward=true --default-repo local-registry:5000 --cache-artifacts=true

    printf "\nCleaning Up $SERVICE_NAME namespace\n"
	kubectl delete namespace "$SERVICE_NAME"
	exit_if_error "\nCould not cleanup $SERVICE_NAME namespace"
fi