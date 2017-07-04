#!/usr/bin/env bash

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
