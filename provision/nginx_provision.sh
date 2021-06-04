#!/bin/bash
sudo yum install -y epel-release nginx
sudo systemctl start nginx

sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

sudo systemctl enable nginxs
