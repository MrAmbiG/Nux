cd /home/
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y perl gcc dkms kernel-devel kernel-headers make zip unzip bzip2 wget git kernel-devel kernel* kernel-devel-$(uname -r) open-vm-tools python36u python36u-libs python36u-devel python36u-pip
yum update -y
ls -l /usr/src/kernels/$(uname -r)
wget -O atom.rpm https://atom.io/download/rpm/
chmod +x atom.rpm 
yum install -y atom.rpm
alias python=python3.6
alias pip=pip3.6
source ~/.bashrc
yum update -y
#reboot -y
# How to use this?
# wget -O - https://github.com/MrAmbiG/Nux/blob/master/centos7startup.sh | bash
