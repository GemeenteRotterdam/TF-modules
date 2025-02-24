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
    default_action = var.network_acls_default_action
    bypass         = var.network_acls_bypass
    virtual_network_subnet_ids = [data.azurerm_subnet.example.id]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
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

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [azurerm_role_assignment.example]
}

resource "azurerm_user_assigned_identity" "mikv" {
  name                = var.identity_name_mikv
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  depends_on          = [azurerm_private_endpoint.example]

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_role_assignment" "cryptoservice" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = var.role_definition_name_cryptoservice
  principal_id         = azurerm_user_assigned_identity.mikv.principal_id
  depends_on           = [azurerm_user_assigned_identity.mikv]
}

resource "azurerm_user_assigned_identity" "github" {
  name                = var.identity_name_github
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  depends_on          = [azurerm_role_assignment.cryptoservice]

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_key_vault_key" "key-2048" {
  name         = var.keyvault_key_name_2048
  key_vault_id = azurerm_key_vault.example.id
  key_type     = var.key_type_2048
  key_size     = var.key_size_2048
  key_opts     = var.key_opts_2048
  depends_on   = [azurerm_user_assigned_identity.github]

  tags = var.tags

  rotation_policy {
    automatic {
      time_after_creation = var.time_after_creation_2048
    }
    expire_after         = var.expire_after_2048
    notify_before_expiry = var.notify_before_expiry_2048
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_key_vault_key" "key-4096" {
  name         = var.keyvault_key_name_4096
  key_vault_id = azurerm_key_vault.example.id
  key_type     = var.key_type_4096
  key_size     = var.key_size_4096
  key_opts     = var.key_opts_4096
  depends_on   = [azurerm_key_vault_key.key-2048]

  tags = var.tags

  rotation_policy {
    automatic {
      time_after_creation = var.time_after_creation_4096
    }

    expire_after         = var.expire_after_4096
    notify_before_expiry = var.notify_before_expiry_4096
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_disk_encryption_set" "example" {
  name                      = var.disk_encryption_set_name
  location                  = data.azurerm_resource_group.resource_group.location
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  key_vault_key_id          = azurerm_key_vault_key.key-2048.versionless_id
  auto_key_rotation_enabled = var.auto_key_rotation_enabled
  encryption_type           = var.encryption_type
  depends_on                = [azurerm_key_vault_key.key-4096]

  identity {
    type         = var.identity_type
    identity_ids = [azurerm_user_assigned_identity.mikv.id]
  }
}

resource "azurerm_role_assignment" "contributor_mi_github" {
  scope                = azurerm_key_vault.example.id // zelfde sub
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}

resource "azurerm_role_assignment" "user_access_mi_github" {
  scope                = azurerm_key_vault.example.id // zelfde sub
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}

resource "azurerm_role_assignment" "kv_contributor_mi_github" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Contributor"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}

resource "azurerm_role_assignment" "private_dns_zone_reader_mi_github" {
  scope                = "/subscriptions/3d8dac72-0f68-451f-9748-3cd509dced16/resourceGroups/RG_Rdam_PF_Connectivity_Private_DNS"
  role_definition_name = "Private DNS Zone Reader"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}

resource "azurerm_role_assignment" "private_dns_zone_arecord_contributor_mi_github" {
  scope                = "/subscriptions/3d8dac72-0f68-451f-9748-3cd509dced16/resourceGroups/RG_Rdam_PF_Connectivity_Private_DNS"
  role_definition_name = "Private DNS Zones A Record Contributor"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}

resource "azurerm_role_assignment" "kv_secrets_user_mi_github" {
  scope                = "/subscriptions/aa20029e-2e39-4966-acb2-70e228663a84/resourceGroups/RG_Rdam_PF_Management_Alg/providers/Microsoft.KeyVault/vaults/KVRdamPFManagementAlg"
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}

resource "azurerm_role_assignment" "kv_reader_mi_github" {
  scope                = "/subscriptions/aa20029e-2e39-4966-acb2-70e228663a84/resourceGroups/RG_Rdam_PF_Management_Alg/providers/Microsoft.KeyVault/vaults/KVRdamPFManagementAlg"
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}

resource "azurerm_role_assignment" "storage_blob_data_contributor_mi_github" {
  scope                = "/subscriptions/aa20029e-2e39-4966-acb2-70e228663a84/resourceGroups/RG_Rdam_PF_Management_tfbackend/providers/Microsoft.Storage/storageAccounts/sardamapplicationsprd001"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  depends_on           = [azurerm_disk_encryption_set.example]
}









