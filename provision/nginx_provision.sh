#! /bin/bash

yum -y install epel-release 

yum -y install nginx

systemctl start nginx
systemctl status nginx
systemctl enable nginx

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

systemctl reload nginx