resource "azurerm_virtual_network" "this" {
  name                           = var.resource_group_name
  address_space                  = var.address_space
  dns_servers                    = var.dns_servers
  resource_group_name            = data.azurerm_resource_group.rg.name
  location                       = data.azurerm_resource_group.rg.location
  private_endpoint_vnet_policies = var.pep_policy
}

resource "azurerm_subnet" "this" {
  for_each                                      = var.subnets
  name                                          = each.key
  virtual_network_name                          = azurerm_virtual_network.this.name
  resource_group_name                           = var.resource_group_name
  address_prefixes                              = each.address_space
  service_endpoint_policy_ids                   = each.service_endpoint_policy_ids
  service_endpoints                             = each.service_endpoints
  default_outbound_access_enabled               = false
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"
}