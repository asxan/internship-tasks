output "firewall_names" {
  value = google_compute_firewall.firewall[*].name
}

output "firewall" {
  value = google_compute_firewall.firewall[*].id
}