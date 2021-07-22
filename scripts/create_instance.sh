#!/bin/bash
# Bash script with google sdk commands for creating 
# infrustructure in the google cloud platform
# Created by Vitali Klymov 
# Last date of changing: 22.07.2021


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
RESERVE_EXTERNAL_IP_NAME2="external-ip-nexus"
RESERVE_EXTERNAL_IP_NAME3="external-ip-slave"
RESERVE_EXTERNAL_IP_NAME4="external-ip-prod"


RESERVE_INTERNAL_IP_NAME1="internal-ip-nginx"
RESERVE_INTERNAL_IP_NAME2="internal-ip-nexus"
RESERVE_INTERNAL_IP_NAME3="internal-ip-slave"
RESERVE_INTERNAL_IP_NAME4="internal-ip-prod"


FIREWALL_RULE_SSH_HTTP="ssh-http-rule"
FIREWALL_RULE_NEXUS="nexus-rule"
FIREWALL_RULE_FROM_NETWORK="rule-anywhere"
FIREWALL_RULE_FOR_JENKINS="jenkins-master-ports"
FIREWALL_RULE_FOR_DOCKER="docker-port"

FIREWALL_RULE_SSH_HTTP_PORTS="tcp:22,tcp:80,tcp:443,tcp:465,icmp"
FIREWALL_RULE_NEXUS_PORTS="tcp:8081"
FIREWALL_RULE_FOR_JENKINS_PORTS="tcp:8080,tcp:8081,tcp:465,tcp:50000"
FIREWALL_RULE_FOR_DOCKER_PORTS="tcp:2375"

INSTANCE_NAME1="jenkins-nginx-instance"
INSTANCE_NAME2="nexus-instance"
INSTANCE_NAME3="slave-instance"
INSTANCE_NAME4="prod-instance"

HOSTNAME1="jenkins-nginx.asxan.ml"
HOSTNAME2="nexus.asxan.ml"
HOSTNAME3="slave.asxan.ml"
HOSTNAME4="pet-clinick.asxan.ml"

MACHINE_TYPE="e2-medium"
COUNT=1
OWNER="vitalii-klymov"

BOOT_DISK_NAME="boot-asxan-disk"
BOOT_DISK_SIZE="32GB"
BOOT_DISK_TYPE="pd-ssd"
IMAGE_TYPE="centos-7-v20200403"
IMAGE_PROJECT="centos-cloud"


SSH_KEY="/Users/vklymov/.ssh/gcloud_gridkey.pub"

ZONE_NAME="asxan"
MANAGED_ZONE="asxan.ml."
TTL=300
RECORD_TYPE_A="A"
DNS_NAME_1="$HOSTNAME1."
DNS_NAME_2="$HOSTNAME2."
DNS_NAME_3="$HOSTNAME3."
DNS_NAME_4="$HOSTNAME4."


# #-------------------------------------------------------------#

ALERT_VAR=$(gcloud compute networks list | grep -o $NETWORK_NAME)
if [ "$ALERT_VAR" == "$NETWORK_NAME" ]; then

    echo """Network with name $NETWORK_NAME has already been existed! 
        Please change network name and other configuration of this resource if you need it"""

else

    gcloud compute networks create $NETWORK_NAME \
    --bgp-routing-mode=regional --mtu=$MTU --subnet-mode=custom \
    --description="This network is for hosting all infrastruction"

fi


ALERT_VAR=$(gcloud compute networks subnets list | grep -o $PUBLIC_SUBNET_NAME)
if [ "$ALERT_VAR" == "$PUBLIC_SUBNET_NAME" ]; then

    echo """Subnet with name $PUBLIC_SUBNET_NAME has already been existed! 
    Please change subnet name and other configuration of this resource if you need it\n"""

else

    gcloud compute networks subnets create $PUBLIC_SUBNET_NAME \
    --network=$NETWORK_NAME \
    --range=$PUBLIC_RANGE \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --description="It is  public subnet" 

fi 


ALERT_VAR=$(gcloud compute networks subnets list | grep -o $PRIVATE_SUBNET_NAME)
if [ "$ALERT_VAR" == "$PRIVATE_SUBNET_NAME" ]; then

    echo """Subnet with name $PRIVATE_SUBNET_NAME has already been existed!
    Please change subner name and other configuration of this resource if you need it\n"""

else

    gcloud compute networks subnets create $PRIVATE_SUBNET_NAME \
    --network=$NETWORK_NAME \
    --range=$PRIVATE_RANGE \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --enable-private-ip-google-access \
    --description="It is private subnet"

fi


ALERT_VAR=$(gcloud compute routers list | grep -o $ROUTER_NAME)
if [ "$ALERT_VAR" == "$ROUTER_NAME" ]; then

    echo """Router with name $ROUTER_NAME has already been existed! 
    Please change router name and other configuration of this resource if you need it\n"""

else

    gcloud compute routers create $ROUTER_NAME \
    --network=$NETWORK_NAME \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --description="It is cloud router which connected to custom network"
fi


ALERT_VAR=$(gcloud compute routers nats list --router=$ROUTER_NAME --router-region=$CLOUDSDK_COMPUTE_REGION | grep -o $NAT_GATEWAY_NAME)
if [ "$ALERT_VAR" == "$NAT_GATEWAY_NAME" ]; then

    echo """Nat gateway with name $NAT_GATEWAY_NAME has already been existed! 
    Please change nat gateway name and other configuration of this resource if you need it\n"""

else

    gcloud compute routers nats create $NAT_GATEWAY_NAME \
    --router=$ROUTER_NAME \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --nat-custom-subnet-ip-ranges="$PRIVATE_SUBNET_NAME" \
    --auto-allocate-nat-external-ips

fi


# #-------------------------------------------------------------#

ALERT_VAR=$(gcloud compute firewall-rules list | grep  -o $FIREWALL_RULE_SSH_HTTP)
if [ "$ALERT_VAR" == "$FIREWALL_RULE_SSH_HTTP" ]; then

    echo """Firewall rule with name $FIREWALL_RULE_SSH_HTTP has already been existed! 
    Please change Firewall rule name and other configuration of this resource if you need it\n"""

else

    gcloud compute firewall-rules create  $FIREWALL_RULE_SSH_HTTP \
    --network=$NETWORK_NAME \
    --action=ALLOW \
    --rules $FIREWALL_RULE_SSH_HTTP_PORTS \
    --source-ranges=$ALL_RANGE \
    --description="It is firewall rule which allow ssh (22) connection from anywhere"

fi


ALERT_VAR=$(gcloud compute firewall-rules list | grep  -o $FIREWALL_RULE_FROM_NETWORK)
if [ "$ALERT_VAR" == "$FIREWALL_RULE_FROM_NETWORK" ]; then

    echo """Firewall rule with name $FIREWALL_RULE_FROM_NETWORK has already been existed! 
    Please change Firewall rule name and other configuration of this resource if you need it\n"""

else

    gcloud compute firewall-rules create $FIREWALL_RULE_FROM_NETWORK \
    --network=$NETWORK_NAME \
    --allow="tcp,udp" \
    --source-ranges=$PUBLIC_RANGE \
    --description="It is firewall rule which allow all ports connections from anywhere in the network"

fi


ALERT_VAR=$(gcloud compute firewall-rules list | grep  -o $FIREWALL_RULE_NEXUS)
if [ "$ALERT_VAR" == "$FIREWALL_RULE_NEXUS" ]; then

    echo """Firewall rule with name $FIREWALL_RULE_NEXUS has already been existed! 
    Please change Firewall rule name and other configuration of this resource if you need it\n"""

else

    gcloud compute firewall-rules create  $FIREWALL_RULE_NEXUS \
    --network=$NETWORK_NAME \
    --action=ALLOW \
    --rules $FIREWALL_RULE_NEXUS_PORTS \
    --source-ranges=$PUBLIC_RANGE \
    --description="The firewall rule for nexus (8081,443)"

fi



ALERT_VAR=$(gcloud compute firewall-rules list | grep  -o $FIREWALL_RULE_FOR_JENKINS)
if [ "$ALERT_VAR" == "$FIREWALL_RULE_FOR_JENKINS" ]; then

    echo """Firewall rule with name $FIREWALL_RULE_FOR_JENKINS has already been existed! 
    Please change Firewall rule name and other configuration of this resource if you need it\n"""

else

    gcloud compute firewall-rules create $FIREWALL_RULE_FOR_JENKINS \
    --network=$NETWORK_NAME \
    --action=ALLOW  \
    --direction=INGRESS \
    --rules=$FIREWALL_RULE_FOR_JENKINS_PORTS \
    --source-ranges=$PUBLIC_RANGE  \
    --target-tags=$FIREWALL_RULE_FOR_JENKINS \
    --description="The firewall rule for jenkins(8080,8081,50000,465)"

fi



ALERT_VAR=$(gcloud compute firewall-rules list | grep  -o $FIREWALL_RULE_FOR_DOCKER)
if [ "$ALERT_VAR" == "$FIREWALL_RULE_FOR_DOCKER" ]; then

    echo """Firewall rule with name $FIREWALL_RULE_FOR_DOCKER has already been existed! 
    Please change Firewall rule name and other configuration of this resource if you need it\n"""

else

    gcloud compute firewall-rules create $FIREWALL_RULE_FOR_DOCKER \
    --network=$NETWORK_NAME \
    --action=ALLOW \
    --direction=INGRESS \
    --rules=$FIREWALL_RULE_FOR_DOCKER_PORTS \
    --source-ranges=$PUBLIC_RANGE \
    --target-tags=$FIREWALL_RULE_FOR_DOCKER \
    --description="The firewall rule for docker external connection"

fi


gcloud compute project-info add-metadata \
--metadata-from-file \
ssh-keys=$SSH_KEY

# #-------------------------------------------------------------#

ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_EXTERNAL_IP_NAME1)
if [ "$ALERT_VAR" == "$RESERVE_EXTERNAL_IP_NAME1" ]; then

    echo """External ip with name $RESERVE_EXTERNAL_IP_NAME1 has already been existed! 
    Please change exteranal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_EXTERNAL_IP_NAME1 \
    --description="It is external ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION 

fi


ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_INTERNAL_IP_NAME1)
if [ "$ALERT_VAR" == "$RESERVE_INTERNAL_IP_NAME1" ]; then

    echo """Internal ip with name $RESERVE_INTERNAL_IP_NAME1 has already been existed! 
    Please change internal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_INTERNAL_IP_NAME1 \
    --description="It is internak ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --subnet=$PUBLIC_SUBNET_NAME 

fi


ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_EXTERNAL_IP_NAME2)
if [ "$ALERT_VAR" == "$RESERVE_EXTERNAL_IP_NAME2" ]; then

    echo """External ip with name $RESERVE_EXTERNAL_IP_NAME2 has already been existed! 
    Please change exteranal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_EXTERNAL_IP_NAME2 \
    --description="It is external ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION 

fi


ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_INTERNAL_IP_NAME2)
if [ "$ALERT_VAR" == "$RESERVE_INTERNAL_IP_NAME2" ]; then

    echo """Internal ip with name $RESERVE_INTERNAL_IP_NAME2 has already been existed! 
    Please change internal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_INTERNAL_IP_NAME2 \
    --description="It is internak ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --subnet=$PUBLIC_SUBNET_NAME 

fi


ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_EXTERNAL_IP_NAME3)
if [ "$ALERT_VAR" == "$RESERVE_EXTERNAL_IP_NAME3" ]; then

    echo """External ip with name $RESERVE_EXTERNAL_IP_NAME3 has already been existed! 
    Please change exteranal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_EXTERNAL_IP_NAME3 \
    --description="It is external ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION 

fi


ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_INTERNAL_IP_NAME3)
if [ "$ALERT_VAR" == "$RESERVE_INTERNAL_IP_NAME3" ]; then

    echo """Internal ip with name $RESERVE_INTERNAL_IP_NAME3 has already been existed! 
    Please change internal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_INTERNAL_IP_NAME3 \
    --description="It is internak ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --subnet=$PUBLIC_SUBNET_NAME 

fi


ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_EXTERNAL_IP_NAME4)
if [ "$ALERT_VAR" == "$RESERVE_EXTERNAL_IP_NAME4" ]; then

    echo """External ip with name $RESERVE_EXTERNAL_IP_NAME4 has already been existed! 
    Please change exteranal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_EXTERNAL_IP_NAME4 \
    --description="It is external ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION 

fi


ALERT_VAR=$(gcloud compute addresses list | grep  -o $RESERVE_INTERNAL_IP_NAME4)
if [ "$ALERT_VAR" == "$RESERVE_INTERNAL_IP_NAME4" ]; then

    echo """Internal ip with name $RESERVE_INTERNAL_IP_NAME4 has already been existed! 
    Please change internal ip name and other configuration of this resource if you need it\n"""

else

    gcloud compute addresses create $RESERVE_INTERNAL_IP_NAME4 \
    --description="It is internak ip address for nginx instance" \
    --region=$CLOUDSDK_COMPUTE_REGION \
    --subnet=$PUBLIC_SUBNET_NAME 

fi

#-------------------------------------------------------------#


ALERT_VAR=$(gcloud compute instances list | grep  -o $INSTANCE_NAME1)
if [ "$ALERT_VAR" == "$INSTANCE_NAME1" ]; then

    echo """Instance with name $INSTANCE_NAME1 has already been existed! 
    Please change instance's name and other configuration of this resource if you need it\n"""

else

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
    --tags=$FIREWALL_RULE_SSH_HTTP,$FIREWALL_RULE_FOR_JENKINS,$FIREWALL_RULE_FOR_DOCKER \
    --network-interface ^:^address=$RESERVE_EXTERNAL_IP_NAME1:network=$NETWORK_NAME:subnet=$PUBLIC_SUBNET_NAME:private-network-ip=$RESERVE_INTERNAL_IP_NAME1
fi



ALERT_VAR=$(gcloud compute instances list | grep  -o $INSTANCE_NAME2)
if [ "$ALERT_VAR" == "$INSTANCE_NAME2" ]; then

    echo """Instance with name $INSTANCE_NAME2 has already been existed! 
    Please change instance's name and other configuration of this resource if you need it\n"""

else

    gcloud compute instances create $INSTANCE_NAME2 \
    --hostname=$HOSTNAME2 \
    --labels ^:^name=$INSTANCE_NAME2:owner=$OWNER:subnet=$PUBLIC_SUBNET_NAME \
    --machine-type=$MACHINE_TYPE \
    --boot-disk-device-name=$BOOT_DISK_NAME \
    --boot-disk-type=$BOOT_DISK_TYPE  \
    --boot-disk-size=$BOOT_DISK_SIZE \
    --image-project=$IMAGE_PROJECT \
    --image=$IMAGE_TYPE \
    --zone=$AVAILABILITY_ZONE_A \
    --tags=$FIREWALL_RULE_SSH_HTTP,$FIREWALL_RULE_NEXUS,$FIREWALL_RULE_FOR_DOCKER \
    --network-interface ^:^address=$RESERVE_EXTERNAL_IP_NAME2:network=$NETWORK_NAME:subnet=$PUBLIC_SUBNET_NAME:private-network-ip=$RESERVE_INTERNAL_IP_NAME2

fi


ALERT_VAR=$(gcloud compute instances list | grep  -o $INSTANCE_NAME3)
if [ "$ALERT_VAR" == "$INSTANCE_NAME3" ]; then

    echo """Instance with name $INSTANCE_NAME3 has already been existed! 
    Please change instance's name and other configuration of this resource if you need it\n"""

else

    gcloud compute instances create $INSTANCE_NAME3 \
    --hostname=$HOSTNAME3 \
    --labels ^:^name=$INSTANCE_NAME3:owner=$OWNER:subnet=$PUBLIC_SUBNET_NAME \
    --machine-type=$MACHINE_TYPE \
    --boot-disk-device-name=$BOOT_DISK_NAME \
    --boot-disk-type=$BOOT_DISK_TYPE  \
    --boot-disk-size=$BOOT_DISK_SIZE \
    --image-project=$IMAGE_PROJECT \
    --image=$IMAGE_TYPE \
    --zone=$AVAILABILITY_ZONE_A \
    --tags=$FIREWALL_RULE_SSH_HTTP,$FIREWALL_RULE_NEXUS,$FIREWALL_RULE_FOR_DOCKER,$FIREWALL_RULE_FOR_JENKINS \
    --network-interface ^:^address=$RESERVE_EXTERNAL_IP_NAME3:network=$NETWORK_NAME:subnet=$PUBLIC_SUBNET_NAME:private-network-ip=$RESERVE_INTERNAL_IP_NAME3

fi


ALERT_VAR=$(gcloud compute instances list | grep  -o $INSTANCE_NAME4)
if [ "$ALERT_VAR" == "$INSTANCE_NAME4" ]; then

    echo """Instance with name $INSTANCE_NAME4 has already been existed! 
    Please change instance's name and other configuration of this resource if you need it\n"""

else

    gcloud compute instances create $INSTANCE_NAME4 \
    --hostname=$HOSTNAME4 \
    --labels ^:^name=$INSTANCE_NAME4:owner=$OWNER:subnet=$PUBLIC_SUBNET_NAME \
    --machine-type=$MACHINE_TYPE \
    --boot-disk-device-name=$BOOT_DISK_NAME \
    --boot-disk-type=$BOOT_DISK_TYPE  \
    --boot-disk-size=$BOOT_DISK_SIZE \
    --image-project=$IMAGE_PROJECT \
    --image=$IMAGE_TYPE \
    --zone=$AVAILABILITY_ZONE_A \
    --tags=$FIREWALL_RULE_SSH_HTTP \
    --network-interface ^:^address=$RESERVE_EXTERNAL_IP_NAME4:network=$NETWORK_NAME:subnet=$PUBLIC_SUBNET_NAME:private-network-ip=$RESERVE_INTERNAL_IP_NAME4

fi

# #-------------------------------------------------------------#


ALERT_VAR=$(gcloud dns managed-zones list | grep -o "$ZONE_NAME" | head -n 1 )
if [ "$ALERT_VAR" == "$ZONE_NAME" ]; then

    echo """Dns zone  with the same name $ZONE_NAME has already been existed! 
    Please change internal ip name and other configuration of this resource if you need it\n"""

else

    gcloud dns managed-zones create $ZONE_NAME \
    --dns-name=$MANAGED_ZONE \
    --description="This dns zone for tasks  public"

fi


# gcloud dns record-sets transaction start \
# --zone=$MANAGED_ZONE

ALERT_VAR=$(gcloud dns record-sets list --zone="$ZONE_NAME"| grep -o "$DNS_NAME_1")
if [ "$ALERT_VAR" == "$DNS_NAME_1" ]; then

    echo """Dns name  with the same name: $DNS_NAME_1 has already been existed! 
    Please change dns record name and other configuration of this resource if you need it\n"""

else

    gcloud dns record-sets create $DNS_NAME_1 \
    --rrdatas=$(gcloud compute addresses list | grep "$RESERVE_EXTERNAL_IP_NAME1" | awk '{ print $2; }' ) \
    --ttl=$TTL \
    --type=$RECORD_TYPE_A \
    --zone=$ZONE_NAME

fi


ALERT_VAR=$(gcloud dns record-sets list --zone="$ZONE_NAME"| grep -o "$DNS_NAME_2")
if [ "$ALERT_VAR" == "$DNS_NAME_2" ]; then

    echo """Dns name  with the same name: $DNS_NAME_2 has already been existed! 
    Please change dns record name and other configuration of this resource if you need it\n"""

else

    gcloud dns record-sets create $DNS_NAME_2 \
    --rrdatas=$(gcloud compute addresses list | grep "$RESERVE_EXTERNAL_IP_NAME2" | awk '{ print $2; }' ) \
    --ttl=$TTL \
    --type=$RECORD_TYPE_A \
    --zone=$ZONE_NAME

fi


ALERT_VAR=$(gcloud dns record-sets list --zone="$ZONE_NAME"| grep -o "$DNS_NAME_3")
if [ "$ALERT_VAR" == "$DNS_NAME_3" ]; then

    echo """Dns name  with the same name: $DNS_NAME_3 has already been existed! 
    Please change dns record name and other configuration of this resource if you need it\n"""

else

    gcloud dns record-sets create $DNS_NAME_3 \
    --rrdatas=$(gcloud compute addresses list | grep "$RESERVE_EXTERNAL_IP_NAME3" | awk '{ print $2; }' ) \
    --ttl=$TTL \
    --type=$RECORD_TYPE_A \
    --zone=$ZONE_NAME

fi


ALERT_VAR=$(gcloud dns record-sets list --zone="$ZONE_NAME"| grep -o "$DNS_NAME_4")
if [ "$ALERT_VAR" == "$DNS_NAME_4" ]; then

    echo """Dns name  with the same name: $DNS_NAME_4 has already been existed! 
    Please change dns record name and other configuration of this resource if you need it\n"""

else

    gcloud dns record-sets create $DNS_NAME_4 \
    --rrdatas=$(gcloud compute addresses list | grep "$RESERVE_EXTERNAL_IP_NAME4" | awk '{ print $2; }' ) \
    --ttl=$TTL \
    --type=$RECORD_TYPE_A \
    --zone=$ZONE_NAME

fi

#-------------------------------------------------------------#