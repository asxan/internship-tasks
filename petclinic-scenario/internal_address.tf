resource "google_compute_address" "first_internal_ip" {
  name = var.RESERVE_INTERNAL_IP_NAME1
  address_type = "INTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  subnetwork = google_compute_subnetwork.public-subnet.id
  description = "The first internal ip address's"
}

resource "google_compute_address" "second_internal_ip" {
  name = var.RESERVE_INTERNAL_IP_NAME2
  address_type = "INTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  subnetwork = google_compute_subnetwork.public-subnet.id
  description = "The second internal ip address's"
}

resource "google_compute_address" "third_internal_ip" {
  name = var.RESERVE_INTERNAL_IP_NAME3
  address_type = "INTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  subnetwork = google_compute_subnetwork.public-subnet.id
  description = "The third internal ip address's"
}

resource "google_compute_address" "fourth_internal_ip" {
  name = var.RESERVE_INTERNAL_IP_NAME4
  address_type = "INTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  subnetwork = google_compute_subnetwork.public-subnet.id
  description = "The fourth internal ip address's"
}