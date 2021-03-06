#!/bin/bash

echo "Install K8s-Master Server"
sleep 3
echo "Disabling swap"
sudo swapoff -a

echo "Update and Upgrade"
sudo apt-get update && sudo apt-get upgrade -y

echo "Install Docker"
sudo apt-get install docker.io

echo "Install kubeadm, kubelet and kubectl"
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
sudo apt-get update

sudo apt-get install kubeadm kubelet kubectl -y

sudo apt-mark hold kubelet kubeadm kubectl

echo "Install Calico for networking"
sudo kubeadm init --pod-network-cidr 192.168.0.0/16

echo "running additional steps"

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

kubectl get node

sudo kubectl taint nodes --all node-role.kubernetes.io/master-
