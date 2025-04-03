module "XXX" {
  source = "./module"

  resource_group_name = ""
  subnet_name         = ""
  subnet_rg           = ""
  subnet_vnet         = ""

  nsg_name               = ""
  vm_name                = ""
  vm_size                = ""
  admin_username         = ""
  admin_password         = ""
  disk_encryption_set_id = ""
  data_disk_name         = ""

  tag_update_schedule = ""
}