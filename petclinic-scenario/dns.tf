resource "google_dns_managed_zone" "asxan_zone" {
  name = var.ZONE_NAME
  dns_name = var.MANAGED_ZONE
  description = "The dns zone for project"
}

resource "google_dns_record_set" "jenkins_nginx_record_set" {
  managed_zone = google_dns_managed_zone.asxan_zone.name
  name = var.DNS_NAME_1
  type = var.RECORD_TYPE_A
  ttl = var.TTL
  rrdatas = [google_compute_address.first_external_ip.address]
}

resource "google_dns_record_set" "nexus_record_set" {
  managed_zone = google_dns_managed_zone.asxan_zone.name
  name = var.DNS_NAME_2
  type = var.RECORD_TYPE_A
  ttl = var.TTL
  rrdatas = [google_compute_address.second_external_ip.address]
}

resource "google_dns_record_set" "slave_record_set" {
  managed_zone = google_dns_managed_zone.asxan_zone.name
  name = var.DNS_NAME_3
  type = var.RECORD_TYPE_A
  ttl = var.TTL
  rrdatas = [google_compute_address.third_external_ip.address]
}

resource "google_dns_record_set" "pet_clinick_record_set" {
  managed_zone = google_dns_managed_zone.asxan_zone.name
  name = var.DNS_NAME_4
  type = var.RECORD_TYPE_A
  ttl = var.TTL
  rrdatas = [google_compute_address.fourth_external_ip.address]
}