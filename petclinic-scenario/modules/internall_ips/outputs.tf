output "internal_address_names" {
  value = google_compute_address.internal_address[*].name
}

output "internal_address_ids" {
  value = google_compute_address.internal_address[*].id
}

output "internal_addresses" {
  value = google_compute_address.internal_address[*].address
}