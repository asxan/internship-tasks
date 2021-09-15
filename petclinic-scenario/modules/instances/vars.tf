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

variable "availability_zone_a" {
  type = string
  description = "availability zone a"
}

variable "" {}