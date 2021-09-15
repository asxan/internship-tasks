variable "project_id" {
  type  = string
  description = "The ID of project where vpc will be created"
}

variable "network_names" {
  type = list(string)
  description = "The name of the network being created"
}

variable "routing_mode" {
  type = string
  description = "The network routing mode (default GLOBAL)"
  default = "GLOBAL"
}

variable "auto_create_subnetworks" {
  type = bool
  description = "When set to 'true' the network is created in 'auto subnet mode' and it will create a subnet for each region automatically"
  default = false
}


variable "delete_default_routes_on_create" {
  type =  bool
  description = "If set to true, default routes '0.0.0.0/0' will be deleted immediately after creation. Defaults to 'false'"
  default = false
}


variable "mtu" {
  type = number
  description = "The maximum transmission unit number Must be a value between 1460 and 1500 inclusive"
  default = 0
}
