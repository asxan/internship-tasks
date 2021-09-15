output "subnets_names" {
  value = google_compute_subnetwork.subnets[*].name
}

output "subnet_id" {
  value = google_compute_subnetwork.subnets[*].id
}

output "subnet_ips_ranges" {
  value = google_compute_subnetwork.subnets[*].ip_cidr_range
}