output "network" {
  value = google_compute_network.vpc_network
  description = "The vpcs which were created"
}
output "network_names" {
  value = google_compute_network.vpc_network[*].name
  description = "The names of vpcs"
}

output "network_id" {
  value = google_compute_network.vpc_network[*].id
  description = "The IDs of vpcs"
}

output "network_self_link" {
  value = google_compute_network.vpc_network[*].self_link
  description = "THE URI of the VPC being created"
}
