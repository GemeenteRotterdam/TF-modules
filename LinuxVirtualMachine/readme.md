The following additional permissions are required for the deployment of this module:
- Get & List for Key Vault "KVRdamPFManagementAlg"

The following needs to be added in the root main.tf for the first time this module is called:

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

- data.tf

data "azurerm_key_vault" "example" {
  name                = var.key_vault_name_for_credentials
  resource_group_name = var.key_vault_rg_for_credentials
  provider            = azurerm.KeyVaultSUB
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = var.secret_username_name
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_disk_encryption_set" "disk_encryption" {
  name                = var.disk_encryption_set_name
  resource_group_name = var.disk_encryption_set_rg
}

- variables.tf

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

variable "disk_encryption_set_name" {
  description = "The name of the existing Disk Encryption Set."
  type        = string
  default     = "des-rdam-huseyin-tf-001"
}

variable "disk_encryption_set_rg" {
  description = "The name of the Resource Group where the Disk Encryption Set exists."
  type        = string
  default     = "rg-rdam-shared-resources-huseyin-tst-001"
}

The following variable values from this module needs to be filled from the data blocks above in main.tf in the root when this module is called upon:

- admin_username            = data.azurerm_key_vault_secret.admin_username.value
- disk_encryption_set_id    = data.azurerm_disk_encryption_set.disk_encryption.id