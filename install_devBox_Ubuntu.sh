#!/bin/bash
UBUNTU_ARCH=$(arch)
sudo apt-get update
sudo apt-get install nfs-kernel-server
wget https://releases.hashicorp.com/vagrant/1.8.4/vagrant_1.8.4_$UBUNTU_ARCH.deb
sudo dpkg -i vagrant_1.8.4_$UBUNTU_ARCH.deb
rm vagrant_1.8.4_$UBUNTU_ARCH.deb
vagrant plugin install vagrant-hostsupdater
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox-5.0
vagrant up