# IRIS Persistence Service

This repository contains the code for the IRIS Persistence Service. It includes:
* Its database Docker image, which is defined by the file Dockerfile at the root of the repository
* Its helm chart, which is defined under the helm folder at the root of the repository

# Developping and Testing just the IRIS Image 

For now, the IRIS Persistence Service does not depend on the existence of the control plane so this image can actully be started outside of Kubernetes as a simple docker container. To do that, you will need a valid `iris.key` file on the **license** folder.

With a license in place, you can:

```bash
./build.sh
./run.sh
```

# Developing and Testing on a Kubernetes Cluster with the control plane

Start your controlplane cluster as per instructions [here](https://bitbucketlb.iscinternal.com/projects/SDS/repos/controlplane/browse).

This procedure is to develop and test the persistence service without having it injected into the cluster by the control plane. This means that:
1. The control plane is not creating the Kubernetes namespace for us
2. The control plane is not injecting the iris.key on our namespace for us
3. The control plane is not injecting the image pull secrets on our namespace for us

We need to do something about the three things above before trying to install our helm chart into our cluster:
1. We will be using the **default** namespace (no need to create one)
2. We will manually inject the license key into the default namespace
3. We will not be using image pull secrets since the image for the service will be pulled from our insecure local registry

This is all being done automatically by the `test-deploy-from-local.sh`.

In order to run this script, make sure you have an `iris.key` under the **license** folder.

