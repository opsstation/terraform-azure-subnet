provider "azurerm" {
  features {}
}


#-----------------------------------------------------------------------------
# Resource Group module call
# Resource group in which all resources will be deployed.
#-----------------------------------------------------------------------------
module "resource_group" {
  source      = "git::git@github.com:opsstation/terraform-azure-resource-group.git"
  name        = local.name
  environment = local.environment
  label_order = local.label_order
  location    = "North Europe"
}


locals {
  name        = "opsstation"
  environment = "it"
  label_order = ["name", "environment"]
}


##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------

module "vnet" {
  source                 = "git::git@github.com:opsstation/terraform-azure-vnet.git"
  name                   = local.name
  environment            = local.environment
  resource_group_name    = module.resource_group.resource_group_name
  location               = module.resource_group.resource_group_location
  address_spaces         = ["10.0.0.0/16"]
  enable_network_watcher = false # To be set true when network security group flow logs are to be tracked and network watcher with specific name is to be deployed.
}




module "subnet" {
  source = "../"

  name        = "app"
  environment = "test"

  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet.vnet_name)

  #subnet
  subnet_names    = ["subnet1", "subnet2"]
  subnet_prefixes = ["10.0.1.0/24", "10.0.2.0/24"]

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

module "subnet_2" {
  source = "../"

  name        = "app"
  environment = "test"

  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet.vnet_name)

  #subnet
  subnet_names    = ["sub3", "sub4"]
  subnet_prefixes = ["10.0.3.0/24", "10.0.4.0/24"]

  # route_table
  enable_route_table = true
  route_table_name   = "test_rt"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}

