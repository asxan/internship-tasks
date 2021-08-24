resource "google_compute_address" "first_external_ip" {
  name = var.RESERVE_EXTERNAL_IP_NAME1
  address_type = "EXTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  description = "The first external ip address's"
}

resource "google_compute_address" "second_external_ip" {
  name = var.RESERVE_EXTERNAL_IP_NAME2
  address_type = "EXTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  description = "The second external ip address's"
}

resource "google_compute_address" "third_external_ip" {
  name = var.RESERVE_EXTERNAL_IP_NAME3
  address_type = "EXTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  description = "The third external ip address's"
}

resource "google_compute_address" "fourth_external_ip" {
  name = var.RESERVE_EXTERNAL_IP_NAME4
  address_type = "EXTERNAL"
  region = var.CLOUDSDK_COMPUTE_REGION
  description = "The fourth external ip address's"
}