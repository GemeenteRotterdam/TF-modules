output "key_id" {
    description = "The id of the key."
    value       = azurerm_key_vault_key.key.id
}

output "key_name" {
    description = "The name of the key."
    value       = azurerm_key_vault_key.key.name
}
