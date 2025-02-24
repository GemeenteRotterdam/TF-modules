The following additional permissions are required for the deployment of this module:

- Get & List for Key Vault "KVRdamPFManagementAlg"
- Private DNS zone reader
- Private DNS zone A-Record contributor
- Private DNS zone A-Record join action

The following needs to be added in the root for the first time:

- locals.tf

locals {
  //Disk Encryption Set
  des_id = "/subscriptions/3c978daf-4ed2-4427-9e31-656744f48380/resourceGroups/rg_rdam_lz_applications_alg/providers/Microsoft.Compute/diskEncryptionSets/DES_Rdam_Applications_RSA_4096"

  // Windows machines  
  vm_size1 = "Standard_E8as_v5"  // 2 CPU - 8GB RAM
  vm_size2 = "Standard_E4as_v5"  // 4 CPU - 16GB RAM
  vm_size3 = "Standard_D4as_v5"  // 4 CPU - 8GB RAM
  vm_size4 = "Standard_D2as_v5"  // 2 CPU - 8GB RAM
  vm_size5 = "Standard_D2s_v5"   // Test SKU

  ID_Rdam_Windows_Server_2019_DC_Gen2_TrustedLaunch = "/subscriptions/aa20029e-2e39-4966-acb2-70e228663a84/resourceGroups/RG_Rdam_PF_Management_Image/providers/Microsoft.Compute/galleries/CG_Rdam_Standaard_Images/images/ID_Rdam_Windows_Server_2019_DC_Gen2_TrustedLaunch"
  ID_Rdam_Windows_Server_2022_DC_Gen2_TrustedLaunch = "/subscriptions/aa20029e-2e39-4966-acb2-70e228663a84/resourceGroups/rg_rdam_pf_management_image/providers/Microsoft.Compute/galleries/CG_Rdam_Standaard_Images/images/ID_Rdam_Windows_Server_2022_DC_Gen2_TrustedLaunch"

  //Linux machines
  vm_linux_size1 = "Standard_D2ls_v5"

}

- providers.tf

provider "azurerm" {
  alias           = "privatednszonesub"
  features {}
  subscription_id = "3d8dac72-0f68-451f-9748-3cd509dced16"
  resource_provider_registrations = "none"
}

provider "azurerm" {
  alias           = "KeyVaultSUB"
  features {}
  subscription_id = "aa20029e-2e39-4966-acb2-70e228663a84"
  resource_provider_registrations = "none"
}

- Data.tf

data "azurerm_private_dns_zone" "vaultcore" {
  name                = var.private_dns_zone_group_name_vaultcore
  resource_group_name = var.resource_group_name_private_dns_zones
  provider            = azurerm.privatednszonesub
}

data "azurerm_private_dns_zone" "file" {
  name                = var.private_dns_zone_group_name_vaultcore
  resource_group_name = var.resource_group_name_private_dns_zones
  provider            = azurerm.privatednszonesub
}

data "azurerm_key_vault" "example" {
  name                = var.key_vault_name_for_credentials
  resource_group_name = var.key_vault_rg_for_credentials
  provider            = azurerm.KeyVaultSUB
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = var.secret_username_name
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = var.secret_password_name
  key_vault_id = data.azurerm_key_vault.example.id
}

- variables.tf

variable "private_dns_zone_group_name_vaultcore" {
  description = "Specifies the Name of the Private DNS Zone Group for key vault."
  type        = string
  default     = "privatelink.vaultcore.azure.net"
}

variable "private_dns_zone_group_name_file" {
  description = "Specifies the Name of the Private DNS Zone Group for key vault."
  type        = string
  default     = "privatelink.file.core.windows.net"
}

variable "resource_group_name_private_dns_zones" {
  description = "The name of the existing resource group in which to create the resource"
  type        = string
  default     = "rg_rdam_pf_connectivity_private_dns"
}

variable "key_vault_name_for_credentials" {
  description = "Specifies the name of the Key Vault."
  type        = string
  default     = "KVRdamPFManagementAlg"
}

variable "key_vault_rg_for_credentials" {
  description = "The name of the Resource Group in which the Key Vault exists."
  type        = string
  default     = "RG_Rdam_PF_Management_Alg"
}

variable "secret_username_name" {
  description = "Specifies the name of the Key Vault Secret."
  type        = string
  default     = "Administrator"
}

variable "secret_password_name" {
  description = "Specifies the name of the Key Vault Secret."
  type        = string
  default     = "AdminPassword"
}

The following variable values from this module needs to be filled from the data blocks above in main.tf in the root when this module is called upon:

-  private_dns_zone_name_kv           = data.azurerm_private_dns_zone.vaultcore.name
-  private_dns_zone_id_kv             = [data.azurerm_private_dns_zone.vaultcore.id]

-  private_dns_zone_name_sa           = data.azurerm_private_dns_zone.file.name
-  private_dns_zone_id_sa             = [data.azurerm_private_dns_zone.file.id]

- admin_username                      = data.azurerm_key_vault_secret.admin_username.value
- admin_password                      = data.azurerm_key_vault_secret.admin_admin_password.value