#!/bin/bash

echo "Install K8s-Master Server"
sleep 3
echo "Disabling swap"
sudo swapoff -a

echo "Update and Upgrade"
sudo apt-get update && sudo apt-get upgrade -y

echo "Install Docker"
sudo apt-get install docker.io -y

echo "Install kubeadm, kubelet and kubectl"
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
sudo apt-get update

sudo apt-get install kubeadm kubelet kubectl -y

sudo apt-mark hold kubelet kubeadm kubectl
