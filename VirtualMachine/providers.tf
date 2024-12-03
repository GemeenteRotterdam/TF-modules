terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      //version = "=3.110.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  tenant_id          = var.tenant_id
  subscription_id    = var.subscription_id
}