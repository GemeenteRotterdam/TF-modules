module "rg_example_dev" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//ResourceGroup?ref=main"

  name         = ""
  location     = var.location
  mi_rg_name   = azurerm_user_assigned_identity.this.resource_group_name
  mi_parent_id = azurerm_user_assigned_identity.this.id

  tags = {
    backup                = ""
    change_number         = ""
    classification        = ""
    clustername           = ""
    department            = ""
    disaster_recovery     = ""
    environment           = ""
    financial_id          = ""
    functional            = ""
    operation_team        = ""
    owner                 = ""
    shared                = ""
    short_name            = ""
    taaknummer_projecten  = ""
  }
}
