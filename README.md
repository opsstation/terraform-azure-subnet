# Terraform-azure-subnet

# Terraform Azure Cloud Subnet Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#examples)
- [Authors](#authors)
- [License](#license)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
This repository contains Terraform code for deploying Azure resources using modules. This README provides an overview of the code and how to use it.

## Usage
To use this module, include it in your Terraform configuration file and provide the required input variables. Below is an example of how to use the module:

# Examples

# Example: default-subnet

```hcl
module "subnet" {
  source               = "git::https://github.com/opsstation/terraform-azure-subnet.git?ref=v1.0.0"
  name                 = "app"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name[0]

  #subnet
  subnet_names    = ["subnet1"]
  subnet_prefixes = ["10.0.1.0/24"]

  # route_table
  enable_route_table = true
  route_table_name   = "default_subnet"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}
```
You can customize the input variables according to your specific requirements.

# Example: name-specific-subnet

```hcl
module "name_specific_subnet" {
  source = "git::https://github.com/opsstation/terraform-azure-subnet.git?ref=v1.0.0"
  name                 = "app"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet.vnet_name)

  #subnet
  specific_name_subnet  = true
  specific_subnet_names = "SpecificSubnet"
  subnet_prefixes       = ["10.0.1.0/24"]

  # route_table
  enable_route_table = true
  route_table_name   = "name_specific_subnet"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}
```
You can customize the input variables according to your specific requirements.

# Example: nat-gateway-subnet

```hcl
module "subnet" {
  source               = "git::https://github.com/opsstation/terraform-azure-subnet.git?ref=v1.0.0"
  name                 = "app"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name

  #subnet
  create_nat_gateway = true
  subnet_names       = ["subnet1", "subnet2"]
  subnet_prefixes    = ["10.0.1.0/24", "10.0.2.0/24"]

  # route_table
  enable_route_table = true
  route_table_name   = "nat_gateway"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}
```
You can customize the input variables according to your specific requirements.

## Examples
For detailed examples on how to use this module, please refer to the [example](https://github.com/opsstation/terraform-azure-subnet/tree/master/_example) directory within this repository.

## Authors
Your Name Replace **MIT** and **OpsStation** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the **MIT** License - see the [LICENSE](https://github.com/opsstation/terraform-azure-subnet/blob/master/LICENSE) file for details.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/opsstation/terraform-azure-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.pip_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.subnet_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_route_table_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.main2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | Flag to control nat gateway creation. | `bool` | `false` | no |
| <a name="input_delegation"></a> [delegation](#input\_delegation) | Configuration delegations on subnet<br>object({<br>  name = object({<br>    name = string,<br>    actions = list(string)<br>  })<br>}) | `map(list(any))` | `{}` | no |
| <a name="input_disable_bgp_route_propagation"></a> [disable\_bgp\_route\_propagation](#input\_disable\_bgp\_route\_propagation) | Boolean flag which controls propagation of routes learned by BGP on that route table. | `bool` | `false` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Flag to control the module creation | `bool` | `true` | no |
| <a name="input_enable_route_table"></a> [enable\_route\_table](#input\_enable\_route\_table) | Flag to control route table creation. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'opsstation'. | `string` | `"opsstation"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_nat_gateway_idle_timeout"></a> [nat\_gateway\_idle\_timeout](#input\_nat\_gateway\_idle\_timeout) | Idle timeout configuration in minutes for Nat Gateway | `number` | `4` | no |
| <a name="input_public_ip_zones"></a> [public\_ip\_zones](#input\_public\_ip\_zones) | Public ip Zones to configure. | `list(string)` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/opsstation/terraform-azure-subnet"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing resource group to be imported. | `string` | `""` | no |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | The name of the route table. | `string` | `null` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | List of objects that represent the configuration of each route. | `list(map(string))` | `[]` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []. | `list(string)` | `[]` | no |
| <a name="input_specific_name_subnet"></a> [specific\_name\_subnet](#input\_specific\_name\_subnet) | n/a | `bool` | `false` | no |
| <a name="input_specific_subnet_names"></a> [specific\_subnet\_names](#input\_specific\_subnet\_names) | A list of subnets inside the vNet. | `string` | `""` | no |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false. | `map(bool)` | `{}` | no |
| <a name="input_subnet_enforce_private_link_service_network_policies"></a> [subnet\_enforce\_private\_link\_service\_network\_policies](#input\_subnet\_enforce\_private\_link\_service\_network\_policies) | A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false. | `bool` | `true` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | A list of public subnets inside the vNet. | `list(string)` | `[]` | no |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes) | The address prefix to use for the subnet. | `list(string)` | `[]` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the virtual network in which the subnet is created in | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | The ID of the NAT Gateway. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The IP address value that was allocated. |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of this Public IP. |
| <a name="output_route_table_associated_subnets"></a> [route\_table\_associated\_subnets](#output\_route\_table\_associated\_subnets) | The collection of Subnets associated with this route table. |
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | The Route Table ID. |
| <a name="output_specific_subnet_address_prefixes"></a> [specific\_subnet\_address\_prefixes](#output\_specific\_subnet\_address\_prefixes) | The address prefixes for the subnet. |
| <a name="output_specific_subnet_id"></a> [specific\_subnet\_id](#output\_specific\_subnet\_id) | The subnet ID. |
| <a name="output_specific_subnet_name"></a> [specific\_subnet\_name](#output\_specific\_subnet\_name) | The name of the subnet. |
| <a name="output_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#output\_subnet\_address\_prefixes) | The address prefixes for the subnet. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The subnet ID. |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The name of the subnet. |
<!-- END_TF_DOCS -->