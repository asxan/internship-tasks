resource "google_dns_record_set" "record_set" {
  count = length(var.dns_names)
  managed_zone = var.managed_zone
  name = element(var.dns_names, count.index)
  type = var.record_type
  ttl = var.ttl
  rrdatas = [element(var.record_data, count.index)]
}