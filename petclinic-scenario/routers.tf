resource "google_compute_router" "router" {
  name = var.ROUTER_NAME
  network = google_compute_network.vpc_network.name
  region = var.CLOUDSDK_COMPUTE_REGION
  description = "Compute router for private subnet"
}

resource "google_compute_router_nat" "nat" {
  name = var.NAT_GATEWAY_NAME
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = google_compute_subnetwork.private-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
