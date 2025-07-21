output "resource_group_id" {
  value = azurerm_resource_group.rg-example-dev.id
}

output "federated_credential_id" {
  value = azurerm_federated_identity_credential.rg-example-dev.id
}