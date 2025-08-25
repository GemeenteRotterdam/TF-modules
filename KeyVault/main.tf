resource "azurerm_key_vault" "this" {
  name                       = var.resource_azurerm_key_vault_this_name
  location                   = data.azurerm_resource_group.resource_group.location
  resource_group_name        = data.azurerm_resource_group.resource_group.name
  sku_name                   = var.sku_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enabled_for_deployment          = var.enabled_for_deployment

  public_network_access_enabled = var.public_network_access_enabled_kv
  enable_rbac_authorization     = var.enable_rbac_authorization

  network_acls {
    default_action             = var.network_acls_default_action
    bypass                     = var.network_acls_bypass
    virtual_network_subnet_ids = [data.azurerm_subnet.this.id]
  }

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })
}

resource "azurerm_private_endpoint" "this" {
  name                = var.resource_azurerm_private_endpoint_this_name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  subnet_id           = data.azurerm_subnet.this.id

  private_service_connection {
    name                           = azurerm_private_endpoint.this.name
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = var.subresource_names_kv
    is_manual_connection           = var.is_manual_connection_kv
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_name_kv
    private_dns_zone_ids = var.private_dns_zone_id_kv
  }

  custom_network_interface_name = "${azurerm_private_endpoint.this.name}-nic"

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_key_vault.this]
}
