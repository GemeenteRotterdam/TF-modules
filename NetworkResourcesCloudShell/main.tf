resource "azurerm_network_security_group" "example" {
  name                = var.nsg_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = var.security_rule["name"]
    description                = var.security_rule["description"]
    priority                   = tonumber(var.security_rule["priority"])  # Ensure priority is a number
    direction                  = var.security_rule["direction"]
    access                     = var.security_rule["access"]
    protocol                   = var.security_rule["protocol"]
    source_port_range          = var.security_rule["source_port_range"]
    destination_port_range     = var.security_rule["destination_port_range"]
    source_address_prefix      = var.security_rule["source_address_prefix"]
    destination_address_prefix = var.security_rule["destination_address_prefix"]
  }

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })
}

resource "azurerm_subnet" "container_subnet" {
  name                 = var.container_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.example.name
  address_prefixes     = var.container_subnet_address_prefix

  delegation {
    name = "Delegation"
   
    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
    }
  }
  depends_on = [azurerm_network_security_group.example]
}

resource "azurerm_network_profile" "example" {
  name                = var.network_profile_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  container_network_interface {
    name = "nic-${var.container_subnet_name}"

    ip_configuration {
      name = "ipconfig-${var.container_subnet_name}"
      subnet_id = azurerm_subnet.container_subnet.id
    }
  }

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_subnet.container_subnet]
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = azurerm_network_profile.example.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.container.object_id
  depends_on           = [azurerm_network_profile.example]
}

resource "azurerm_relay_namespace" "example" {
  name                = var.relay_namespace_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku_name = var.relay_namespace_sku

  tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_role_assignment.network_contributor]
}

resource "azurerm_role_assignment" "contributor" {
  scope                = azurerm_relay_namespace.example.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_service_principal.container.object_id
  depends_on           = [azurerm_relay_namespace.example]
}

resource "azurerm_subnet" "relay_subnet" {
  name                 = var.relay_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.example.name
  address_prefixes     = var.relay_subnet_address_prefix

  depends_on = [azurerm_role_assignment.contributor]
}

resource "azurerm_private_endpoint" "example" {
  name                = var.private_endpoint_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.relay_subnet.id

  private_service_connection {
    name                           = var.private_endpoint_name
    private_connection_resource_id = azurerm_relay_namespace.example.id
    is_manual_connection           = var.private_endpoint_is_manual_connection
    subresource_names              = var.private_endpoint_subresources_names
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_ids
  }

   tags = merge(data.azurerm_resource_group.rg.tags, var.extra_tags, { source = "Terraform" })

  depends_on = [azurerm_subnet.relay_subnet]
}

resource "azurerm_subnet" "storage_subnet" {
  name                 = var.storage_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.example.name
  address_prefixes     = var.storage_subnet_address_prefix

  service_endpoints = ["Microsoft.Storage"]

  depends_on = [azurerm_private_endpoint.example]
}