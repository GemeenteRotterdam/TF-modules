output "key_vault_id" {
  value = azurerm_key_vault.example.id
}

output "managed_identity_id" {
  value = azurerm_user_assigned_identity.mikv.id
}
