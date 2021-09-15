output "external_address_names" {
  value = google_compute_address.external_address[*].name
}

output "external_address_ids" {
  value = google_compute_address.external_address[*].id
}

output "external_addresses" {
  value = google_compute_address.external_address[*].address
}