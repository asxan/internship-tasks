#! /bin/bash

# Install nginx

yum -y install epel-release 

yum -y install nginx

systemctl start nginx
systemctl status nginx
systemctl enable nginx

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

systemctl reload nginx

# Install jenkins

# Set up firewalld

firewall-cmd --permanent --add-port=8080/tcp

firewall-cmd --reload

# Disable SELinux

setenforce 0

sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

