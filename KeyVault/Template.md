module "XXX" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//KeyVault?ref=main"

  resource_group_name = ""
  subnet_name         = ""
  subnet_vnet         = ""
  subnet_rg           = ""

  tenant_name = ""
  app_name    = ""
  description = ""
  environment = ""
  volgnr_kv   = ""
  volgnr_pep  = ""

  private_dns_zone_name_kv = data.azurerm_private_dns_zone.vaultcore.name
  private_dns_zone_id_kv   = [data.azurerm_private_dns_zone.vaultcore.id]
}