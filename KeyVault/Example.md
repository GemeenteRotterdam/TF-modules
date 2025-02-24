Use this example to copy and paste it in your code if you need this module.

module "testKV" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//KeyVault?ref=main"

  resource_group_name = ""
  subnet_name = ""
  subnet_rg = ""
  subnet_vnet = ""

  keyvault_name = ""
  private_endpoint_name_for_kv = ""

  private_dns_zone_name_kv = data.azurerm_private_dns_zone.vaultcore.name
  private_dns_zone_id_kv = [data.private_dns_zone_group_name_vaultcore.id]

  tags = local.tags

}
