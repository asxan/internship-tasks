variable "zone_name" {
  type = string
  description = "The list of dns zone names"
  default = ""
}

variable "managed_zone" {
  type = string
  description = "The list of domains for manages zones"
  default = ""
}

variable "visibility" {
  type = string
  description = "The zone visibility: public zone are  exposed to the internet"
  default = "public"
}

variable "description" {
  type = string
  description = "Description for dns zones"
  default = ""
}
