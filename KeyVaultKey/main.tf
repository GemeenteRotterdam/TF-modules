resource "azurerm_key_vault_key" "key" {
  key_vault_id = var.key_vault_id
  name         = var.key_name
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_opts

  rotation_policy {
    automatic {
      time_before_expiry = var.key_rotation
    }

    expire_after         = var.key_lifetime
    notify_before_expiry = var.key_notification
  }

  lifecycle {
    ignore_changes = [
      expiration_date
    ]
  }
}
