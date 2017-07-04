# kubernetes-tutorial

Learnings from [Hello Minikube](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/) tutorial.

## Commands

```
$ ./kubernetes-tutorial.sh --help

kubernetes-tutorial commands:

setup     1. Installs Minikube, kubectl and docker-machine-driver-xhyve.
          2. Starts Minikube cluster.
          3. Configure Minikube context.

build     Build your Docker image, using the Minikube Docker daemon

deploy    Create a Deployment that manages a Pod

expose    Make the containers accessible from outside the Kubernetes virtual network

open      Automatically opens up a browser window using a local IP address that serves your app

update    Update the image of your Deployment

clean     Can clean up the resources
```
