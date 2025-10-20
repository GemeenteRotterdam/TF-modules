module "example" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//StandaardResourcesPerSub?ref=main"

  resource_group_name = ""
  subnet_name         = ""
  subnet_vnet         = ""
  subnet_rg           = ""

  keyvault_name            = ""
  keyvault_key_name        = ""
  identity_name_mikv       = ""
  disk_encryption_set_name = ""

  private_endpoint_name_for_kv = ""
  private_dns_zone_name_kv     = data.azurerm_private_dns_zone.vaultcore.name
  private_dns_zone_id_kv       = [data.azurerm_private_dns_zone.vaultcore.id]
}