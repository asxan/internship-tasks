variable "address_names" {
  type = list(string)
  description = "The list of internal address names"
}

variable "region" {
  type = string
  description = "The region in which internal ips will be created"
}

variable "subnetwork" {
  type = string
  description = "The subnetwork in which internal ips will be created"
}