#!/usr/bin/env bash

# Print each command before executing
set -x

APP_NAME=hello-node

function _help() {
cat <<EOH
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
EOH
}

case ${1} in
  setup)
    # Install Minikube and kubectl
    brew cask install minikube

    # Use Homebrew to install the xhyve driver and set its permissions:
    brew install docker-machine-driver-xhyve
    sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

    # Determine whether you can access sites like
    # https://cloud.google.com/container-registry/ directly without a proxy, by
    # opening a new terminal and using
    curl --proxy "" https://cloud.google.com/container-registry/

    # Start the Minikube cluster
    #The --vm-driver=xhyve flag specifies that you are using Docker for Mac. The
    #default VM driver is VirtualBox.
    minikube start --vm-driver=xhyve

    # Now set the Minikube context. The context is what determines which cluster
    # kubectl is interacting with. You can see all your available contexts in the
    # ~/.kube/config file.
    kubectl config use-context minikube
    ;;

  build)
    # Build your Docker image, using the Minikube Docker daemon.
    eval $(minikube docker-env)
    docker build -t $APP_NAME:v1 .
    ;;

  deploy)
    kubectl run $APP_NAME --image=$APP_NAME:v1 --port=8080
    kubectl get deployments
    ;;

  expose)
    kubectl expose deployment $APP_NAME --type=LoadBalancer
    kubectl get services
    ;;

  open)
    minikube service $APP_NAME
    ;;

  update)
    eval $(minikube docker-env)
    docker build -t $APP_NAME:v2 .
    kubectl set image deployment/$APP_NAME $APP_NAME=$APP_NAME:v2
    ;;

  clean)
    kubectl delete service $APP_NAME
    kubectl delete deployment $APP_NAME
    ;;

  *|help|-h)
    _help
    ;;
esac
