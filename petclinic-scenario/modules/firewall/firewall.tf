resource "google_compute_firewall" "firewall" {
  count = length(var.firewall_names)
  name = element(var.firewall_names, count.index)
  network = var.network_name

   allow {
    protocol = element(var.protocol, count.index )
    ports = element(var.ports, count.index)
  }

  direction = element(var.direction, count.index)
  source_ranges = element(var.source_ranges ,count.index )
}