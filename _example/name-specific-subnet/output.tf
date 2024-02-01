output "specific_subnet_id" {
  description = "The subnet ID."
  value       = module.name_specific_subnet.specific_subnet_id
}

output "specific_subnet_name" {
  description = "The name of the subnet."
  value       = module.name_specific_subnet.specific_subnet_name
}


output "address_prefixes" {
  description = "The address prefixes for the subnet."
  value       = module.name_specific_subnet.specific_subnet_address_prefixes
}

output "route_table_id" {
  description = "The Route Table ID."
  value       = module.name_specific_subnet.route_table_id
}

output "route_table_associated_subnets" {
  description = "The collection of Subnets associated with this route table."
  value       = module.name_specific_subnet.route_table_associated_subnets
}
