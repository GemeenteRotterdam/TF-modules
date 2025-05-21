data "azurerm_key_vault" "vault" {
    name = var.keyvault_name
    resource_group_name = var.resource_group_name
}
