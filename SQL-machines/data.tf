data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  resource_group_name  = var.subnet_rg
  virtual_network_name = var.subnet_vnet
}
