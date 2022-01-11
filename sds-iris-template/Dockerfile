# FROM amirsamary/intersystems:base_iris-1.5.0
FROM containers.intersystems.com/iscinternal/sds/base_iris:1.11.3
# ARG BASE_IRIS_IMAGE
# FROM $BASE_IRIS_IMAGE

LABEL maintainer="Angel Lopez <alopez@intersystems.com>"

# Adding source code that will be loaded by the installer
ADD --chown=irisowner:irisuser ./${IRIS_PROJECT_FOLDER_NAME}/ $IRIS_APP_SOURCEDIR

# Running the installer. This will load the source code and clean up the image
RUN /sds/iris-installer.sh