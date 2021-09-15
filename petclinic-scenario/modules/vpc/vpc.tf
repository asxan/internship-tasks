resource    "google_compute_network"    "vpc_network" {
  count = length(var.network_names)
  name = element(var.network_names, count.index)
  project = var.project_id
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
  mtu = var.mtu
    description = "The ${tostring(element(var.network_names, count.index ))} network"
}
