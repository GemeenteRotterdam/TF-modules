The following templates can be used to call this module:
Replace all "XXX" with the same uniquely chosen value! (Ctrl+H)

- main.tf

module "XXX" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//WindowsVirtualMachine?ref=main"

  subnet_name = var.XXX.subnet_name
  subnet_rg   = var.XXX.subnet_rg
  subnet_vnet = var.XXX.subnet_vnet

  resource_group_name = var.XXX.resource_group_name

  NSG_name       = var.XXX.nsg_name
  vm_name        = var.XXX.vm_name
  vm_size        = var.XXX.vm_size
  data_disk_name = var.XXX.data_disk_name

  admin_username         = var.XXX.admin_username
  admin_password         = var.XXX.admin_password
  disk_encryption_set_id = var.XXX.disk_encryption_set_id
  source_image_id        = var.XXX.source_image_id

  OU_path = var.XXX.OU_path
}

- variables.tf

variable "XXX" {
  description = "Configuration for the Windows virtual machine module and related resources"
  type = object({
    resource_group_name    = string
    subnet_name            = string
    subnet_rg              = string
    subnet_vnet            = string
    nsg_name               = string
    vm_name                = string
    vm_size                = string
    data_disk_name         = string
    admin_username         = string
    admin_password         = string
    source_image_id        = string
    disk_encryption_set_id = string
    OU_path                = string
  })

  validation {
    condition     = can(regex("^OU=.*DC=.*$", var.XXX.OU_path))
    error_message = "The OU Path must start with 'OU=' and contain 'DC=' components."
  }
}

- terraform.tfvars

XXX = {
  resource_group_name    = "" // Set the existing resource group name
  subnet_name            = "" // Set the existing subnet name
  subnet_rg              = "" // Set the resource group name where the subnet is in
  subnet_vnet            = "" // Set the existing vnet name where subnet is in
  nsg_name               = "" // Set the name for the nsg
  vm_name                = "" // Set the name of the vm 
  vm_size                = //Choose the desired SKU in locals.tf ex: local.vm_size3
  data_disk_name         = "" // Set the name of the data disk
  admin_username         = data.azurerm_key_vault_secret.admin_username.value
  admin_password         = data.azurerm_key_vault_secret.admin_password.value
  source_image_id        = //Choose the desired image in locals.tf ex: local.ID_Rdam_Windows_Server_2022_DC_Gen2_TrustedLaunch
  disk_encryption_set_id = data.azurerm_disk_encryption_set.disk_encryption.id
  OU_path                = //Set the path for the domain join of the vm ex: "OU=Management servers,OU=Servers,DC=rotterdam,DC=local"
}