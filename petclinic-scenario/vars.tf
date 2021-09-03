variable "project_id" {
  type  = string
  description = "Project id in the google cloud platform"
  default = "gd-gcp-gd-internship-kha"
}

variable "CLOUDSDK_COMPUTE_REGION" {
  type = string
  description = "cloud region"
  default = "us-central1"
}

variable "AVAILABILITY_ZONE_A" {
  type = string
  description = "availability zone a"
  default = "us-central1-a"
}

variable "AVAILABILITY_ZONE_B" {
  type = string
  description = "availability zone b"
  default = "us-central1-b"
}

variable "AVAILABILITY_ZONE_C" {
  type = string
  description = "availability zone c"
  default = "us-central1-c"
}

variable "NETWORK_NAME" {
  type = string
  description = "VPC name"
  default = "tasks-network"
}

variable "PUBLIC_SUBNET_NAME" {
  type = string
  description = "public subnet name"
  default = "public-subnet"
}

variable "PRIVATE_SUBNET_NAME" {
  type = string
  description = "private subnet name"
  default = "private-subnet"
}

variable "ROUTER_NAME" {
  type = string
  description = "router name"
  default = "tasks-router"
}

variable "NAT_GATEWAY_NAME" {
  type = string
  description = "nat-gateway name"
  default = "nat-tasks-gateway"
}

variable "PUBLIC_RANGE" {
  type = string
  description = "cidr block for public subnet"
  default = "10.10.20.0/24"
}

variable "PRIVATE_RANGE" {
  type = string
  description = "cidr block for private subnet"
  default = "10.10.30.0/24"
}
variable "ALL_RANGE" {
  type = string
  description = "All range for firewall rules"
  default = "0.0.0.0/0"
}

variable "MTU" {
  type = number
  description = "The maximum transmission unit number"
  default = 1500
}

variable "RESERVE_EXTERNAL_IP_NAME1" {
  type = string
  description = "1 external ip address"
  default = "external-ip-jenkins"
}

variable "RESERVE_EXTERNAL_IP_NAME2" {
  type = string
  description = "2 external ip address"
  default = "external-ip-nexus"
}

variable "RESERVE_EXTERNAL_IP_NAME3" {
  type = string
  description = "3 external ip address"
  default = "external-ip-slave"
}

variable "RESERVE_EXTERNAL_IP_NAME4" {
  type = string
  description = "4 external ip address"
  default = "external-ip-prod"
}

variable "RESERVE_INTERNAL_IP_NAME1" {
  type = string
  description = "1 external ip address"
  default = "internal-ip-jenkins"
}

variable "RESERVE_INTERNAL_IP_NAME2" {
  type = string
  description = "2 external ip address"
  default = "internal-ip-nexus"
}

variable "RESERVE_INTERNAL_IP_NAME3" {
  type = string
  description = "3 external ip address"
  default = "internal-ip-slave"
}

variable "RESERVE_INTERNAL_IP_NAME4" {
  type = string
  description = "4 external ip address"
  default = "internal-ip-prod"
}

# Name of firewall rules
variable "FIREWALL_RULE_SSH_HTTP" {
  type = string
  description = "Name of firewall rule"
  default = "ssh-http-rule"
}

variable "FIREWALL_RULE_NEXUS" {
  type = string
  description = "Name of firewall rule"
  default = "nexus-rule"
}

variable "FIREWALL_RULE_SMTP" {
  type  = string
  description = "Name of smtp firewall rule"
  default = "smtp-rule"
}

variable "FIREWALL_RULE_FROM_NETWORK" {
  type = string
  description = "Name of firewall rule"
  default = "rule-anywhere"
}

variable "FIREWALL_RULE_FOR_JENKINS" {
  type = string
  description = "Name of firewall rule"
  default = "jenkins-master-ports"
}

variable "FIREWALL_RULE_FOR_DOCKER" {
  type = string
  description = "Name of firewall rule"
  default = "docker-port"
}

# Ports for firewall rules
variable "FIREWALL_RULE_SSH_HTTP_PORTS" {
  type = list(string)
  description = "Fire wall rule with ssh, http, https and smtp ports"
  default = ["22", "80", "443"]
}

variable "FIREWALL_RULE_SMTP_PORTS" {
  type = list(string)
  description = "Smtp ports"
  default = ["465"]
}

variable "FIREWALL_RULE_NEXUS_PORTS" {
  type = list(string)
  description = "Fire wall rule with ssh, http, https and smtp ports"
  default = ["8081", "443"]
}

variable "FIREWALL_RULE_FOR_JENKINS_PORTS" {
  type = list(string)
  description = "Fire wall rule with ssh, http, https and smtp ports"
  default = ["8080", "8081", "465", "50000"]
}

variable "FIREWALL_RULE_FOR_DOCKER_PORTS" {
  type = list(string)
  description = "Fire wall rule with ssh, http, https and smtp ports"
  default = ["2375"]
}

# Instance`s names
variable "INSTANCE_NAME1" {
  type = string
  description = "instance name"
  default = "jenkins-nginx-instance"
}

variable "INSTANCE_NAME2" {
  type = string
  description = "instance name"
  default = "nexus-instance"
}

variable "INSTANCE_NAME3" {
  type = string
  description = "instance name"
  default = "slave-instance"
}


variable "INSTANCE_NAME4" {
  type = string
  description = "instance name"
  default = "prod-instance"
}

# Instance`s hostnames

variable "HOSTNAME1" {
  type = string
  description = "instance`s hostname"
  default = "jenkins-nginx.asxan.ml"
}

variable "HOSTNAME2" {
  type = string
  description = "instance`s hostname"
  default = "nexus.asxan.ml"
}


variable "HOSTNAME3" {
  type = string
  description = "instance`s hostname"
  default = "slave.asxan.ml"
}


variable "HOSTNAME4" {
  type = string
  description = "instance`s hostname"
  default = "pet-clinick.asxan.ml"
}


variable "MACHINE_TYPE" {
  type = string
  description = "compute engine machine type"
  default = "e2-medium"
}
variable "COUNT_1" {
  type  =  number
  description = "Count 1 of resources"
  default = 1
}


variable "OWNER" {
  type = string
  description = "owner of the resources"
  default = "vitalii-klymov"
}

variable "BOOT_DISK_NAME" {
  type = string
  description = "name of boot disk"
  default = "boot-asxan-disk"
}

variable "BOOT_DISK_SIZE" {
  type = number
  description = "boot disk size"
  default = 32
}

variable "BOOT_DISK_TYPE" {
  type = string
  description = "boot disk type"
  default = "pd-ssd"
}

variable "IMAGE_TYPE" {
  type = string
  description = "type of boot image"
  default = "centos-7-v20210817" // centos-7-v20210817
}

variable "IMAGE_PROJECT" {
  type = string
  description = "project of images"
  default = "centos-cloud"
}

variable "SSH_KEY" {
  type =  string
  description = "The path to ssh key"
  default = "/Users/vklymov/.ssh/gcloud_gridkey.pub"
}

# DNS zone
variable "ZONE_NAME" {
  type = string
  description = "dns zone name"
  default = "asxan"
}

variable "MANAGED_ZONE" {
  type = string
  description = "the managed zone domain"
  default = "asxan.ml."
}

variable "TTL" {
  type = number
  description = "time to live number of request"
  default = 300
}

variable "RECORD_TYPE_A" {
  type = string
  description = "record type"
  default = "A"
}

variable "DNS_NAME_1" {
  type = string
  description = "1 dns name"
  default = "jenkins-nginx.asxan.ml."
}

variable "DNS_NAME_2" {
  type = string
  description = "2 dns name"
  default = "nexus.asxan.ml."
}

variable "DNS_NAME_3" {
  type = string
  description = "3 dns name"
  default = "slave.asxan.ml."
}

variable "DNS_NAME_4" {
  type = string
  description = "4 dns name"
  default = "pet-clinick.asxan.ml."
}
