#-----------------------------------------------------
# Terraform petclinic
# Made by Vitalii Klymov
#-----------------------------------------------------

provider "google" {
  project = var.project_id
  region = "us-central1"
  zone = "us-central1-a"
}

terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket-internship"
    prefix = "petclinick-manifest-tfstate-files/terraform.tfstate"
  }
}

module "vpcs" {
  source = "./modules/vpc"
  network_names = var.network_names
  project_id = var.project_id
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
  mtu = var.mtu
}


module "public_subnets" {
  source = "./modules/subnets"
  subnet_names = var.public_subnets_names
  public_ranges = var.public_ranges
  region = var.cloudsdk_compute_region
  vpc_name = module.vpcs.network_names[0]
}


module "internal_ips" {
  source = "./modules/internall_ips"
  address_names = var.internal_ip_names
  region = var.cloudsdk_compute_region
  subnetwork = module.public_subnets.subnet_id[0]
}

module "external_ips" {
  source = "./modules/external_ips"
  address_names = var.external_ip_names
  region = var.cloudsdk_compute_region
}

module "firewalls" {
  source = "./modules/firewall"
  firewall_names = var.firewall_rule_names
  network_name = module.vpcs.network_names[0]
  protocol = var.firewall_rules_protocols
  ports = var.firewall_rules_ports
  direction = var.directions
  source_ranges = var.source_ranges
}








module "dns_managed_zone" {
  source = "./modules/dns_zone"
  zone_name = var.zone_name
  managed_zone = var.managed_zone
  visibility = var.visibility
  description = "The asxan dns zone for project"
}


module "record_set" {
  source = "./modules/dns_records"
  managed_zone = module.dns_managed_zone.dns_zone_name
  dns_names = var.dns_names
  record_type = var.record_type_a
  ttl = var.ttl
  record_data = module.external_ips.external_addresses
}
