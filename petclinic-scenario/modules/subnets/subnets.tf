resource "google_compute_subnetwork" "subnets" {
  count = length(var.subnet_names)
  name = element(var.subnet_names, count.index)
  ip_cidr_range = element(var.public_ranges, count.index)
  region = var.region
  network = var.vpc_name
  description = "It is (name: ${tostring(element(var.subnet_names,count.index ))}) subnet"
}