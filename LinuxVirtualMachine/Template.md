module "XXX" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//LinuxVirtualMachine?ref=main"

  resource_group_name = ""
  subnet_name         = ""
  subnet_vnet         = ""
  subnet_rg           = ""

  vm_name  = ""
  vm_size  = ""

  disk_encryption_set_id = ""
  admin_username         = ""
  admin_password         = ""
}
