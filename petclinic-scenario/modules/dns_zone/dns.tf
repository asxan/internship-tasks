resource "google_dns_managed_zone" "zone" {
  name = var.zone_name
  dns_name = var.managed_zone
  visibility = var.visibility
  description = var.description
}