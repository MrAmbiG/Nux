#!/bin/bash
# tested on AWS CentOS 7.5 ec2-instance
# Installs docker and kubernetes on a centOS system
# basic things first. recommended.

# add docker repo if not present
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum -y update
sudo yum -y install qemu-kvm libvirt libvirt-daemon-kvm
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# virtualbox
sudo wget -P /etc/yum.repos.d http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
sudo yum install -y VirtualBox-5.0 # you might want to change it to a newer version

# Install docker
sudo yum -y install docker
sudo systemctl enable docker
sudo systemctl start docker

# delete temp.txt and kubernetes.repo if created
sudo rm -rf temp.txt
sudo rm -rf  /etc/yum.repos.d/kubernetes.repo

# add kubernetes repository to your repolist
sudo echo '[kubernetes]' >> temp.txt
sudo echo 'name=Kubernetes' >> temp.txt
sudo echo 'baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64' >> temp.txt
sudo echo 'enabled=1' >> temp.txt
sudo echo 'gpgcheck=1' >> temp.txt
sudo echo 'repo_gpgcheck=1' >> temp.txt
sudo echo 'gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg' >> temp.txt
sudo mv temp.txt /etc/yum.repos.d/kubernetes.repo

# disable selinux
sudo setenforce 0
sudo sed -i 's/'SELINUX=enforcing'/'SELINUX=permissive'/g' /etc/selinux/config

# Install kubernetes
sudo yum -y install kubelet kubeadm kubectl
sudo systemctl start kubelet
sudo systemctl enable kubelet

# some hasks to get the kubernetes cluster working
sudo rm -rf temp.txt
sudo echo 'net.bridge.bridge-nf-call-ip6tables = 1' >> temp.txt
sudo echo 'net.bridge.bridge-nf-call-iptables = 1' >> temp.txt
sudo mv temp.txt /etc/sysctl.d/k8s.conf
sudo sysctl --system
echo 1 > /proc/sys/net/ipv4/ip_forward
