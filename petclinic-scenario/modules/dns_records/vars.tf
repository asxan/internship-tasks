variable "managed_zone" {
  type = string
  description = "The dns zone"
  default = ""
}

variable "dns_names" {
  type = list
  description = "The dns name for associate"
  default = []
}

variable "record_type" {
  type = string
  description = "The default record type"
  default = "A"
}

variable "ttl" {
  type = number
  description = "The default ttl count"
  default = 300
}

variable "record_data" {
  type = list
  description = "The record data for associate with dns name"
  default = []
}