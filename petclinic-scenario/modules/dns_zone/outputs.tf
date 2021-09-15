output "dns_zone_name" {
  value = google_dns_managed_zone.zone.name
}

output "dns_zone_dns_name" {
  value = google_dns_managed_zone.zone.dns_name
}

output "dns_zone_nameservers" {
  value = google_dns_managed_zone.zone.name_servers
}