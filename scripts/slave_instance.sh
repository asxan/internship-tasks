#!/bin/bash
#Created by Vitali Klymov

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

RESERVE_EXTERNAL_IP_NAME="external-ip-nginx"
RESERVE_INTERNAL_IP_NAME="internal-ip-nginx"

FIREWALL_RULE_SSH_HTTP="ssh-http-rule"
FIREWALL_RULE_FROM_NETWORK="rule-anywhere"

INSTANCE_NAME1="jenkins-slave1-instance"
MACHINE_TYPE=e2-medium
HOSTNAME="jenkins-slave.asxan.ml"
COUNT=1
OWNER="vitalii-klymov"

BOOT_DISK_NAME="boot-asxan-disk"
BOOT_DISK_SIZE="32GB"
BOOT_DISK_TYPE="pd-ssd"
IMAGE_TYPE="centos-7-v20200403"
IMAGE_PROJECT="centos-cloud"


SSH_KEY="/Users/vklymov/.ssh/gcloud_key.pub"

# gcloud compute project-info add-metadata \
# --metadata-from-file \
# ssh-keys=$SSH_KEY


gcloud compute instances create $INSTANCE_NAME1 \
--hostname=$HOSTNAME \
--labels ^:^name=$INSTANCE_NAME1:owner=$OWNER:subnet=$PUBLIC_SUBNET_NAME \
--machine-type=$MACHINE_TYPE \
--boot-disk-device-name=$BOOT_DISK_NAME \
--boot-disk-type=$BOOT_DISK_TYPE  \
--boot-disk-size=$BOOT_DISK_SIZE \
--image-project=$IMAGE_PROJECT \
--image=$IMAGE_TYPE \
--zone=$AVAILABILITY_ZONE_A \
--tags=$FIREWALL_RULE_SSH_HTTP,$FIREWALL_RULE_FROM_NETWORK \
--network-interface ^:^address=$RESERVE_EXTERNAL_IP_NAME:network=$NETWORK_NAME:subnet=$PUBLIC_SUBNET_NAME:private-network-ip=$RESERVE_INTERNAL_IP_NAME \
--metadata-from-file=startup-script=/Users/vklymov/Codes/internship-tasks/provision/nginx_provision.sh