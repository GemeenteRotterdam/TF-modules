The following templates can be used to call this module:
Replace the "XXX" with a uniquely chosen value!

- main.tf

module "XXX" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//WindowsVirtualMachine?ref=main"

  resource_group_name = "" // Set the existing resource group name

  subnet_name = "" // Set the existing subnet name
  subnet_vnet = "" // Set the resource group name where the subnet is in
  subnet_rg   = "" // Set the existing vnet name where subnet is in

  nsg_name       = "" // Set the name for the nsg
  vm_name        = "" // Set the name of the vm
  vm_size        =    //Choose the desired SKU in locals.tf ex: local.vm_size3
  data_disk_name = "" // Set the name of the data disk

  admin_username         = data.azurerm_key_vault_secret.admin_username.value // Don't change this value
  admin_password         = data.azurerm_key_vault_secret.admin_password.value // Don't change this value
  disk_encryption_set_id = data.azurerm_disk_encryption_set.disk_encryption.id // Don't change this value
  source_image_id        = //Choose the desired image in locals.tf ex: local.ID_Rdam_Windows_Server_2022_DC_Gen2_TrustedLaunch

  domain_join_fqdn     = "" //Choose between rotterdam.local and azdev.local
  domain_join_username = data.azurerm_key_vault_secret.domain_join_username.value
  domain_join_password = data.azurerm_key_vault_secret.domain_join_password.value

  OU_path             = "" // Set the path for the domain join of the vm ex: "OU=Management servers,OU=Servers,DC=rotterdam,DC=local"
  tag_update_schedule = "" // Choose from: "dinsdag 23:00", "donderdag 00:00", "maandag 23:00", "vrijdag 01:00", "woensdag 00:00", "handmatig"
}