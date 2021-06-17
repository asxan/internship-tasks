#! /bin/bash

# Install nginx

yum -y install epel-release 
yum -y install wget
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

#Install java
#yum -y update 
yum install -y java-11-openjdk-devel

echo "export JAVA_HOME=$(ls -1  /usr/lib/jvm/java*/jre/bin/java)" >> ~/.bash_profile

source .bash_profile
# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins java-11-openjdk-devel
systemctl daemon-reload
systemctl start jenkins
systemctl status jenkins
#cat /var/lib/jenkins/secrets/initialAdminPassword