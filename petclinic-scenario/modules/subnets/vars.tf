variable "subnet_names" {
  type = list(string)
  description = "The list of subnets names"
}

variable "public_ranges" {
  type = list(string)
  description = "The list of ip ranges for subnetworks"
}

variable "region" {
  type = string
  description = "The region in which subnets will be created"
}

variable "vpc_name" {
  type = string
  description = "Vpc name in which subnets will be created"
  default = "default"
}