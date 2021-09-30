variable "image_family" {
  type = string
  description = "Os family of images"
  default = ""
}

variable "image_project" {
  type = string
  description = "image project"
  default = ""
}

variable "instance_names" {
  type = list
  description = "Instance name"
}

variable "hostnames" {
  type = list
  description = "List of hostnames"
}

variable "machine_type" {
  type = string
  description = "compute engine machine type"
  default = "e2-medium"
}

variable "owner" {
  type = string
  description = "owner of the resources"
  default = "user"
}

variable "boot_disk_type" {
  type = string
  description = "boot disk type"
  default = "pd-ssd"
}

variable "boot_disk_size" {
  type = number
  description = "boot disk size"
  default = 32
}

variable "availability_zone" {
  type = string
  description = "availability zone"
}

variable "machine_image" {
  type = list(string)
  description = "The List machine boot image"
}

variable "network_tags" {
  type  = list(list(string))
  description = "The list of network firewall rules"
}

variable "vpc_name" {
  type = string
  description = "The vpc name in which instance will be located"
  default = "default"
}

variable "subnet" {
  type = string
  description = "The subnet name in which instance will be created"
  default = "default"
}

variable "internal_ip" {
  type = list(string)
  description = "The internal ip address for instance"
}

variable "external_ip" {
  type = list(string)
  description = "The external ip address for instance"
}

variable "path_to_ssh_key_file" {
  type = string
  description = "The path to ssh key file for metadata"
}