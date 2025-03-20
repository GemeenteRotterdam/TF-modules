module "XXX" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//NetworkResourcesCloudShell?ref=main"

  resource_group_name = ""
  vnet_name           = ""
  vnet_rg             = ""

  nsg_name                        = ""
  container_subnet_name           = ""
  container_subnet_address_prefix = ""

  network_profile_name        = ""
  relay_namespace_name        = ""
  relay_subnet_name           = ""
  relay_subnet_address_prefix = ""

  private_endpoint_name       = ""
  private_dns_zone_group_name = data.azurerm_private_dns_zone.servicebus.name
  private_dns_zone_ids        = [data.azurerm_private_dns_zone.servicebus.id]

  storage_subnet_name           = ""
  storage_subnet_address_prefix = ""
}