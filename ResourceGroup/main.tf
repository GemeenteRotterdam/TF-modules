resource "azurerm_resource_group" "rg-example-dev" {
  name     = var.name
  location = var.location
  tags = {
    backup                 = var.tags.backup
    "change number"        = var.tags.change_number
    classification         = var.tags.classification
    clustername            = var.tags.clustername
    department             = var.tags.department
    "disaster recovery"    = var.tags.disaster_recovery
    environment            = var.tags.environment
    "financial id"         = var.tags.financial_id
    functional             = var.tags.functional
    "operation team"       = var.tags.operation_team
    owner                  = var.tags.owner
    shared                 = var.tags.shared
    "short name"           = var.tags.short_name
    "taaknummer projecten" = var.tags.taaknummer_projecten
  }
}

resource "azurerm_federated_identity_credential" "rg-example-dev" {
  name                = azurerm_resource_group.rg-example-dev.name
  resource_group_name = var.rg_name_mi
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = var.mi_parent_id
  subject             = "repo:GemeenteRotterdam/${azurerm_resource_group.rg-example-dev.name}:environment:production"
}