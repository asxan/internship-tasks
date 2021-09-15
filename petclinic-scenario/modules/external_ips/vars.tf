variable "address_names" {
  type = list(string)
  description = "The list of external address names"
}

variable "region" {
  type = string
  description = "The region in which external ips will be created"
}