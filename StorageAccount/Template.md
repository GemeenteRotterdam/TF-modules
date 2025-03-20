module "XXX" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//StorageAccount?ref=main"
  // Bestaande resources
  resource_group_name = ""
  subnet_name         = ""
  subnet_vnet         = ""
  subnet_rg           = ""

  // resources die worden aangemaakt
  keyvault_name                = ""
  identity_name                = ""
  private_endpoint_name_for_kv = ""

  storage_account_name         = ""
  private_endpoint_name_for_sa = ""
  keyvault_key_name            = ""

  private_dns_zone_name_kv = data.azurerm_private_dns_zone.vaultcore.name
  private_dns_zone_id_kv   = [data.azurerm_private_dns_zone.vaultcore.id]

  private_dns_zone_name_sa = data.azurerm_private_dns_zone.blob.name
  private_dns_zone_id_sa   = [data.azurerm_private_dns_zone.blob.id]
}