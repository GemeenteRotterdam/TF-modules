data "azurerm_client_config" "current" {}

//data "azurerm_resource_group" "resource_group" {
//  name = var.resource_group_name
//}

data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  virtual_network_name = var.subnet_vnet
  resource_group_name  = var.subnet_rg
}
