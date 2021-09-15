output "dns-names" {
  value = google_dns_record_set.record_set[*].name
}