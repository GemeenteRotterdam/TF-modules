Use this example to copy and paste it in your code if you need this module.

module "TestVM" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//WindowsVirtualMachine?ref=main"

  subnet_name = ""
  subnet_rg   = ""
  subnet_vnet = ""

  resource_group_name = ""

  NSG_name       = ""
  vm_name        = ""
  vm_size        = local.vm_size3 // Choose the desired size from locals.tf
  data_disk_name = ""

  admin_username         = data.azurerm_key_vault_secret.admin_username.value
  admin_password         = data.azurerm_key_vault_secret.admin_password.value
  disk_encryption_set_id = data.azurerm_disk_encryption_set.disk_encryption.id
  source_image_id        = local.ID_Rdam_Windows_Server_2022_DC_Gen2_TrustedLaunch // Choose the desired image from locals.tf

  OU_path = "OU=Management servers,OU=Servers,DC=rotterdam,DC=local" // this is an example, change the OU if needed
  tags    = local.tags
