variable "firewall_names" {
  type = list
  description = "The list of firewall rules"
}

variable "network_name" {
  type = string
  description = "The name of vpc"
  default = "default"
}

variable "protocol" {
  type = list
  description = "The list of protocol names"
}

variable "ports" {
  type = list(list(string))
  description = "The list if lists which contained an ports values"
}

variable "direction" {
  type = list(string)
  description = "The direction of traffic"
}

variable "source_ranges" {
  type = list(list(string))
  description = "Source ranges for traffic"
}