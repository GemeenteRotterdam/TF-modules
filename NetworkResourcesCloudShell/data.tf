data "azurerm_client_config" "current" {}

data "azuread_service_principal" "container" {
  display_name = var.azure_container_service_name
}

data "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}

