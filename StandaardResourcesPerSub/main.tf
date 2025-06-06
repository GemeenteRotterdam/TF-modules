resource "azurerm_key_vault" "example" {
  name                       = var.keyvault_name
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
    virtual_network_subnet_ids = [data.azurerm_subnet.example.id]
  }

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = var.role_definition_name
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on           = [azurerm_key_vault.example]
}

resource "azurerm_private_endpoint" "example" {
  name                = var.private_endpoint_name_for_kv
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  subnet_id           = data.azurerm_subnet.example.id

  private_service_connection {
    name                           = var.private_endpoint_name_for_kv
    private_connection_resource_id = azurerm_key_vault.example.id
    subresource_names              = var.subresource_names_kv
    is_manual_connection           = var.is_manual_connection_kv
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_name_kv
    private_dns_zone_ids = var.private_dns_zone_id_kv
  }

  custom_network_interface_name = "${var.private_endpoint_name_for_kv}-nic"

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_role_assignment.example]
}

resource "azurerm_user_assigned_identity" "mikv" {
  name                = var.identity_name_mikv
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  depends_on          = [azurerm_private_endpoint.example]

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })
}

resource "azurerm_role_assignment" "cryptoservice" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = var.role_definition_name_cryptoservice
  principal_id         = azurerm_user_assigned_identity.mikv.principal_id
  depends_on           = [azurerm_user_assigned_identity.mikv]
}

resource "azurerm_key_vault_key" "key" {
  name         = var.keyvault_key_name
  key_vault_id = azurerm_key_vault.example.id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_opts
  depends_on   = [azurerm_role_assignment.cryptoservice]

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })

  rotation_policy {
    automatic {
      time_after_creation = var.time_after_creation
    }
    expire_after         = var.expire_after
    notify_before_expiry = var.notify_before_expiry
  }
}

resource "azurerm_disk_encryption_set" "example" {
  name                      = var.disk_encryption_set_name
  location                  = data.azurerm_resource_group.resource_group.location
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  key_vault_key_id          = azurerm_key_vault_key.key.versionless_id
  auto_key_rotation_enabled = var.auto_key_rotation_enabled
  encryption_type           = var.encryption_type
  depends_on                = [azurerm_key_vault_key.key]

  identity {
    type         = var.identity_type
    identity_ids = [azurerm_user_assigned_identity.mikv.id]
  }

  tags = merge(data.azurerm_resource_group.resource_group.tags, var.extra_tags, { source = "Terraform" })
}





