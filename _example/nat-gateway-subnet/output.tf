output "subnet_name" {
  description = "The name of the subnet."
  value       = module.subnet.subnet_name
}

output "subnet_id" {
  description = "The subnet ID."
  value       = module.subnet.subnet_id
}


output "address_prefixes" {
  description = "The address prefixes for the subnet."
  value       = module.subnet.subnet_address_prefixes
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = module.subnet.nat_gateway_id
}

output "public_ip_address" {
  description = "The IP address value that was allocated."
  value       = module.subnet.public_ip_address
}

output "public_ip_id" {
  description = " The ID of this Public IP."
  value       = module.subnet.public_ip_id
}

output "route_table_id" {
  description = "The Route Table ID."
  value       = module.subnet.route_table_id
}

output "route_table_associated_subnets" {
  description = "The collection of Subnets associated with this route table."
  value       = module.subnet.route_table_associated_subnets
}

