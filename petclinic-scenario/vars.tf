variable "project_id" {
  type  = string
  description = "Project id in the google cloud platform"
  default = "gd-gcp-gd-internship-kha"
}

variable "cloudsdk_compute_region" {
  type = string
  description = "cloud region"
  default = "us-central1"
}

variable "availability_zone_a" {
  type = string
  description = "availability zone a"
  default = "us-central1-a"
}

variable "availability_zone_b" {
  type = string
  description = "availability zone b"
  default = "us-central1-b"
}

variable "availability_zone_c" {
  type = string
  description = "availability zone c"
  default = "us-central1-c"
}

variable "network_names" {
  type = list(string)
  description = "VPC names"
  default = ["tasks-network"]
}

variable "public_subnets_names" {
  type = list(string)
  description = "public subnet name"
  default = ["public-subnet"]
}

variable "private_subnet_name" {
  type = list(string)
  description = "private subnet name"
  default = ["private-subnet"]
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



variable "routing_mode" {
  type = string
  description = "The network routing mode"
  default = "REGIONAL"
}

variable "delete_default_routes_on_create" {
  type = bool
  description = "If set to true, default routes '0.0.0.0/0' will be deleted immediately after creation. Defaults to 'false'"
  default = false
}

variable "auto_create_subnetworks" {
  type = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range."
  default = false
}

variable "mtu" {
  type = number
  description = "The maximum transmission unit number"
  default = 1500
}

# Names of external ips

variable "external_ip_names" {
  type = list(string)
  description = "The list of external ip names"
  default = [
  "external-ip-jenkins",
  "external-ip-nexus",
  "external-ip-slave",
  "external-ip-prod"
  ]
}

# Names of internal ips

variable "internal_ip_names" {
  type = list(string)
  description = "The list of internal ip names"
  default = [
  "internal-ip-jenkins",
  "internal-ip-nexus",
  "internal-ip-slave",
  "internal-ip-prod"
  ]
}

# Name of firewall rules

variable "firewall_rule_names" {
  type = list(string)
  description = "List of firewall rule names"
  default = [
    "ssh-http-rule",
    "smtp-rule",
    "nexus-rule",
    "jenkins-master-ports",
    "docker-port-rule"
  ]
}

# Ports for firewall rules
variable "firewall_rules_ports" {
  type = list(list(string))
  description = "The list of list with firewall rule ports"
  default = [
  ["22", "80", "443"],  // ssh_http_ports
  ["465"],              // smtp_ports
  ["8081", "443"],      // nexus_ports
  ["8080", "8081", "50000"], // jenkins_ports
  ["2375"]                          // docker_ports
  ]
}

variable "firewall_rules_protocols" {
  type = list(string)
  description = "The list of firewall rules protocols"
  default = [
    "tcp",
    "tcp",
    "tcp",
    "tcp",
    "tcp"
  ]
}

variable "source_ranges" {
  type = list(list(string))
  description = "The list of list with source ranges for traffic"
  default = [
  ["0.0.0.0/0"], // all_ranges
  ["0.0.0.0/0"], // all_ranges
  ["0.0.0.0/0"], // all_ranges
  ["10.10.20.0/24"], // public_ranges
  ["10.10.20.0/24"]  // public_ranges
  ]
}

variable "directions" {
  type = list(string)
  description = "The list of directions"
  default = [
    "INGRESS",
    "INGRESS",
    "INGRESS",
    "INGRESS",
    "INGRESS"
  ]
}


variable "public_ranges" {
  type = list(string)
  description = "cidr block for public subnet"
  default = ["10.10.20.0/24"]
}

variable "private_ranges" {
  type = list(string)
  description = "cidr block for private subnet"
  default = ["10.10.30.0/24"]
}
variable "all_range" {
  type = string
  description = "All range for firewall rules"
  default = "0.0.0.0/0"
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


variable "owner" {
  type = string
  description = "owner of the resources"
  default = "vitalii-klymov"
}

variable "BOOT_DISK_NAME" {
  type = string
  description = "name of boot disk"
  default = "boot-asxan-disk"
}

variable "boot_disk_size" {
  type = number
  description = "boot disk size"
  default = 32
}

variable "boot_disk_type" {
  type = string
  description = "boot disk type"
  default = "pd-ssd"
}

variable "IMAGE_TYPE" {
  type = string
  description = "type of boot image"
  default = "centos-7-v20210817" // centos-7-v20200403
}

variable "image_family" {
  type = string
  description = "Os family of images"
  default = "centos-7"
}

variable "image_project" {
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
variable "zone_name" {
  type = string
  description = "dns zone name"
  default = "asxan"
}

variable "managed_zone" {
  type = string
  description = "the managed zone domain"
  default = "asxan.ml."
}

variable "visibility" {
  type = string
  description = "The zone visibility: public zone are  exposed to the internet"
  default = "public"
}

variable "ttl" {
  type = number
  description = "time to live number of request"
  default = 300
}

variable "record_type_a" {
  type = string
  description = "record type"
  default = "A"
}


variable "dns_names" {
  type = list(string)
  description = "The list of dns name"
  default = [
    "jenkins-nginx.asxan.ml.",
    "nexus.asxan.ml.",
    "slave.asxan.ml.",
    "pet-clinick.asxan.ml."
  ]
}