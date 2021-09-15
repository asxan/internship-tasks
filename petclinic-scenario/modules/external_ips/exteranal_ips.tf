resource "google_compute_address" "external_address" {
  count = length(var.address_names)
  name = element(var.address_names, count.index)
  address_type = "EXTERNAL"
  region = var.region
  description = "The ${tostring(element(var.address_names, count.index))} ip address's"
}