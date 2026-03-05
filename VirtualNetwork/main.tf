resource "azurerm_virtual_network" "this" {
  name                           = var.virtual_network_name
  address_space                  = var.address_space
  dns_servers                    = var.dns_servers // statisch 10.240.4.5, 10.240.4.6
  resource_group_name            = data.azurerm_resource_group.rg.name
  location                       = data.azurerm_resource_group.rg.location
  //private_endpoint_vnet_policies = var.pep_policy weghalen
}

resource "azurerm_subnet" "this" {
  for_each                                      = var.subnets
  name                                          = each.key //dynamisch
  virtual_network_name                          = azurerm_virtual_network.this.name
  resource_group_name                           = var.resource_group_name
  address_prefixes                              = each.value.address_space // dynamisch
  service_endpoint_policy_ids                   = each.value.service_endpoint_policy_ids
  service_endpoints                             = each.value.service_endpoints
  default_outbound_access_enabled               = false
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"
// delegation toevoegen, alleen als waarde niet null is

}
