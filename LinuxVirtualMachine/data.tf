data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  resource_group_name  = var.subnet_rg
  virtual_network_name = var.subnet_vnet
}

data "azurerm_ssh_public_key" "ssh" {
  name                = var.ssh_key_name
  resource_group_name = var.ssh_key_rg
}