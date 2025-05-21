module "XXX" {
  source              = "git::https://github.com/GemeenteRotterdam/TF-modules.git//KeyVaultKey?ref=main"
  resource_group_name = var.resource_group_name
  keyvault_name       = var.keyvault_name
  key_name            = var.key_name
  key_type            = var.key_type
  key_size            = var.key_size
  key_opts            = var.key_opts
  key_lifetime        = var.key_lifetime
  key_notification    = var.key_notification
  key_rotation        = var.key_rotation
}
