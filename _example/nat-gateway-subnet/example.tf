provider "azurerm" {
  skip_provider_registration = "true"

  features {}
}

##-----------------------------------------------------------------------------
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "git::https://github.com/opsstation/terraform-azure-resource-group.git?ref=v1.0.0"
  name        = "app"
  environment = "test"
  label_order = ["name", "environment", ]
  location    = "North Europe"
}

##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------
module "vnet" {
  source              = "git::https://github.com/opsstation/terraform-azure-vnet.git?ref=v1.0.0"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

module "subnet" {
  source = "../.."

  name        = "app"
  environment = "test"

  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet[*].vnet_name)

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
