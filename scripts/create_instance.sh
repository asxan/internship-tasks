#!/bin/bash
# Created by Vitali Klymov

CLOUDSDK_COMPUTE_REGION="us-central1" 
AVAILABILITY_ZONE_A="$CLOUDSDK_COMPUTE_REGION-a"
AVAILABILITY_ZONE_B="$CLOUDSDK_COMPUTE_REGION-b"
AVAILABILITY_ZONE_C="$CLOUDSDK_COMPUTE_REGION-c"

NETWORK_NAME="tasks-network"
PUBLIC_SUBNET_NAME="public-subnet"
PRIVATE_SUBNET_NAME="private-subnet"
ROUTER_NAME="tasks-router"
NAT_GATEWAY_NAME="nat-tasks-gateway"
PUBLIC_RANGE="10.10.20.0/24"
PRIVATE_RANGE="10.10.30.0/24"
ALL_RANGE="0.0.0.0/0"
MTU="1500"

RESERVE_EXTERNAL_IP_NAME1="external-ip-nginx"
RESERVE_INTERNAL_IP_NAME1="internal-ip-nginx"

FIREWALL_RULE_SSH_HTTP="ssh-http-rule"
FIREWALL_RULE_SSH_HTTP_PORTS="tcp:22,tcp:80,tcp:443,icmp"
FIREWALL_RULE_FROM_NETWORK="rule-anywhere"
FIREWALL_RULE_FOR_JENKINS="jenkins-master-ports"

INSTANCE_NAME1="jenkins-nginx-instance"
INSTANCE_NAME2="nexus-instance"
MACHINE_TYPE=e2-medium
HOSTNAME1="jenkins-nginx.asxan.ml"
HOSTNAME2="je"
COUNT=1
OWNER="vitalii-klymov"

BOOT_DISK_NAME="boot-asxan-disk"
BOOT_DISK_SIZE="32GB"
BOOT_DISK_TYPE="pd-ssd"
IMAGE_TYPE="centos-7-v20200403"
IMAGE_PROJECT="centos-cloud"


SSH_KEY="/Users/vklymov/.ssh/gcloud_key.pub"

# gcloud compute networks create $NETWORK_NAME \
# --bgp-routing-mode=regional --mtu=$MTU --subnet-mode=custom \
# --description="This network is for hosting all infrastruction"


# gcloud compute networks subnets create $PUBLIC_SUBNET_NAME \ 
# --network=$NETWORK_NAME \
# --range=$PUBLIC_RANGE \
# --region=$CLOUDSDK_COMPUTE_REGION \
# --description="It is  public subnet" 


# gcloud compute networks subnets create $PRIVATE_SUBNET_NAME \
# --network=$NETWORK_NAME \
# --range=$PRIVATE_RANGE \
# --region=$CLOUDSDK_COMPUTE_REGION \
# --enable-private-ip-google-access \
# --description="It is private subnet"


# gcloud compute routers create $ROUTER_NAME \
# --network=$NETWORK_NAME \
# --region=$CLOUDSDK_COMPUTE_REGION \
# --description="It is cloud router which connected to custom network"


# gcloud compute routers nats create $NAT_GATEWAY_NAME \
# --router=$ROUTER_NAME \
# --region=$CLOUDSDK_COMPUTE_REGION \
# --nat-custom-subnet-ip-ranges="$PRIVATE_SUBNET_NAME" \
# --auto-allocate-nat-external-ips


# gcloud compute firewall-rules create  $FIREWALL_RULE_SSH_HTTP \
# --network=$NETWORK_NAME \
# --action=ALLOW \
# --rules $FIREWALL_RULE_SSH_HTTP_PORTS \
# --source-ranges=$ALL_RANGE \
# --description="It is firewall rule which allow ssh (22) connection from anywhere"


# gcloud compute firewall-rules create $FIREWALL_RULE_FROM_NETWORK \
# --network=$NETWORK_NAME \
# --allow="tcp,udp" \
# --source-ranges=$PUBLIC_RANGE \
# --description="It is firewall rule which allow all ports connections from anywhere in the network"


# gcloud compute project-info add-metadata \
# --metadata-from-file \
# ssh-keys=$SSH_KEY


# gcloud compute addresses create $RESERVE_EXTERNAL_IP_NAME \
# --description="It is external ip address for nginx instance" \
# --region=$CLOUDSDK_COMPUTE_REGION 


# gcloud compute addresses create $RESERVE_INTERNAL_IP_NAME \
# --description="It is internak ip address for nginx instance" \
# --region=$CLOUDSDK_COMPUTE_REGION \
# --subnet=$PUBLIC_SUBNET_NAME 


gcloud compute instances create $INSTANCE_NAME1 \
--hostname=$HOSTNAME1 \
--labels ^:^name=$INSTANCE_NAME1:owner=$OWNER:subnet=$PUBLIC_SUBNET_NAME \
--machine-type=$MACHINE_TYPE \
--boot-disk-device-name=$BOOT_DISK_NAME \
--boot-disk-type=$BOOT_DISK_TYPE  \
--boot-disk-size=$BOOT_DISK_SIZE \
--image-project=$IMAGE_PROJECT \
--image=$IMAGE_TYPE \
--zone=$AVAILABILITY_ZONE_A \
--tags=$FIREWALL_RULE_SSH_HTTP,$FIREWALL_RULE_FROM_NETWORK,$FIREWALL_RULE_FOR_JENKINS \
--network-interface ^:^address=$RESERVE_EXTERNAL_IP_NAME1:network=$NETWORK_NAME:subnet=$PUBLIC_SUBNET_NAME:private-network-ip=$RESERVE_INTERNAL_IP_NAME1 \
--metadata-from-file=startup-script=/Users/vklymov/Codes/internship-tasks/provision/nginx_provision.sh