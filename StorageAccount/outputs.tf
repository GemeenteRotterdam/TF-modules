output "key_vault_id" {
  value = azurerm_key_vault.example.id
}

output "managed_identity_id" {
  value = azurerm_user_assigned_identity.example.id
}

output "key_vault_key_id" {
  value = azurerm_key_vault_key.example.id
}

output "storage_account_id" {
  value = azurerm_storage_account.example.id
}

output "managed_identity_client_id" {
  value = azurerm_user_assigned_identity.example.client_id
}
