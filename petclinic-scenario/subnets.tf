resource "google_compute_subnetwork" "public-subnet" {
  name = var.PUBLIC_SUBNET_NAME
  ip_cidr_range = var.PUBLIC_RANGE
  region = var.CLOUDSDK_COMPUTE_REGION
  network = google_compute_network.vpc_network.name
  description = "It is  public subnet"
}

resource "google_compute_subnetwork" "private-subnet" {
  name = var.PRIVATE_SUBNET_NAME
  ip_cidr_range = var.PRIVATE_RANGE
  region = var.CLOUDSDK_COMPUTE_REGION
  network = google_compute_network.vpc_network.name
  description = "It is private subnet"
}
