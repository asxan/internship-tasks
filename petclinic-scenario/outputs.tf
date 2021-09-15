output "internal_ip_names" {
  value = module.internal_ips.internal_address_names
}

output "internal_ip_addresses" {
  value = module.internal_ips.internal_addresses
}

output "external_ip_names" {
  value = module.external_ips.external_address_names
}

output "external_ip_address" {
  value = module.external_ips.external_addresses
}

output "public_subnet_names" {
  value = module.public_subnets.subnets_names
}

output "public_subnet_ids" {
  value = module.public_subnets.subnet_id
}

output "public_subnet_ip_ranges" {
  value = module.public_subnets.subnet_ips_ranges
}

output "vpc_name" {
  value = module.vpcs.network_names
}

output "vpcs_ids" {
  value = module.vpcs.network_id
}
