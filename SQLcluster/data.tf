data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "example" {
  name = var.existing_vnet_name
  resource_group_name = var.existing_vnet_rg
}

data "azurerm_subnet" "example" {
  name = var.existing_subnet_name
  virtual_network_name = var.existing_vnet_name
  resource_group_name  = var.existing_vnet_rg 
}