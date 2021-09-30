#-----------------------------------------------------
# Terraform petclinic
# Made by Vitalii Klymov
#-----------------------------------------------------

provider "google" {
  project = var.project_id
  region = var.cloudsdk_compute_region
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

  depends_on = [module.vpcs]
}


module "internal_ips" {
  source = "./modules/internall_ips"
  address_names = var.internal_ip_names
  region = var.cloudsdk_compute_region
  subnetwork = module.public_subnets.subnet_id[0]

  depends_on = [
  module.public_subnets
  ]
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

  depends_on = [
  module.vpcs
  ]
}

module "ssh_key" {
  source = "./modules/metadata"
  ssh_key = var.ssh_key
}




module "instances" {
  source = "./modules/instances"
  instance_names = var.instance_names
  hostnames = var.hostnames
  machine_type = var.machine_type
  owner = var.owner

  boot_disk_type = var.boot_disk_type
  boot_disk_size = var.boot_disk_size
  machine_image = var.image_names
  //machine_image = data.google_compute_image.centos_image.name

  availability_zone = data.google_compute_zones.available.names[0]

  network_tags = [
    [
      module.firewalls.firewall_names[0],
      module.firewalls.firewall_names[1],
      module.firewalls.firewall_names[3],
      module.firewalls.firewall_names[4],
    ],
    [
      module.firewalls.firewall_names[0],
      module.firewalls.firewall_names[2],
      module.firewalls.firewall_names[4],
    ],
    [
      module.firewalls.firewall_names[0],
      module.firewalls.firewall_names[1],
      module.firewalls.firewall_names[2],
      module.firewalls.firewall_names[3],
      module.firewalls.firewall_names[4],
    ],
    [
      module.firewalls.firewall_names[0],
    ]
  ]

  vpc_name = module.vpcs.network_names[0]
  subnet = module.public_subnets.subnets_names[0]
  internal_ip = module.internal_ips.internal_addresses
  external_ip = module.external_ips.external_addresses
  path_to_ssh_key_file = var.ssh_key

  depends_on = [
    module.ssh_key,
    module.vpcs,
    module.public_subnets,
    module.internal_ips,
    module.external_ips,
    module.firewalls
  ]
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
