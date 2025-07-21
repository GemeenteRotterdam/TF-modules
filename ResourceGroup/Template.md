module "rg_example_dev" {
  source = "./modules/resource-group"

  name         = ""
  location     = var.location
  rg_name_mi   = azurerm_user_assigned_identity.this.resource_group_name
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