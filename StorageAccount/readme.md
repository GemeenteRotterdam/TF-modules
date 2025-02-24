The following additional permissions are required for the deployment of this module:
- Private DNS zone reader
- Private DNS zone A-Record contributor
- Private DNS zone A-Record join action

The following needs to be added in the root for the first time:

- providers.tf

provider "azurerm" {
  alias           = "privatednszonesub"
  features {}
  subscription_id = "3d8dac72-0f68-451f-9748-3cd509dced16"
  resource_provider_registrations = "none"
}

- Data.tf

data "azurerm_private_dns_zone" "vaultcore" {
  name                = var.private_dns_zone_group_name_vaultcore
  resource_group_name = var.resource_group_name_private_dns_zones
  provider            = azurerm.privatednszonesub
}

data "azurerm_private_dns_zone" "blob" {
  name                = var.private_dns_zone_group_name_blob
  resource_group_name = var.resource_group_name_private_dns_zones
  provider            = azurerm.privatednszonesub
}

- variables.tf

variable "private_dns_zone_group_name_vaultcore" {
  description = "Specifies the Name of the Private DNS Zone Group for key vault."
  type        = string
  default     = "privatelink.vaultcore.azure.net"
}

variable "private_dns_zone_group_name_blob" {
  description = "Specifies the Name of the Private DNS Zone Group for storage account."
  type        = string
  default     = "privatelink.blob.core.windows.net"
}

variable "resource_group_name_private_dns_zones" {
  description = "The name of the existing resource group in which to create the resource"
  type        = string
  default     = "rg_rdam_pf_connectivity_private_dns"
}

The following variable values from this module needs to be filled from the data blocks above in main.tf in the root when this module is called upon:

-  private_dns_zone_name_kv           = data.azurerm_private_dns_zone.vaultcore.name
-  private_dns_zone_id_kv             = [data.azurerm_private_dns_zone.vaultcore.id]
  
-  private_dns_zone_name_sa           = data.azurerm_private_dns_zone.blob.name
-  private_dns_zone_id_sa             = [data.azurerm_private_dns_zone.blob.id] 