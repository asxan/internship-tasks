output "firewall_names" {
  value = google_compute_firewall.firewall[*].name
}

output "firewall_ids" {
  value = google_compute_firewall.firewall[*].id
}