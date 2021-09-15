resource "google_compute_address" "internal_address" {
  count = length(var.address_names)
  name = element(var.address_names, count.index)
  address_type = "INTERNAL"
  region = var.region
  subnetwork = var.subnetwork
  description = "The ${tostring(element(var.address_names, count.index))} ip address's"
}