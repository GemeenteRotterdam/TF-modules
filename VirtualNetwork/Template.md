module "vnet-rdam-terraform-tst-001" {

  source               = "git::https://github.com/GemeenteRotterdam/TF-modules.git//VirtualNetwork?ref=main"
  virtual_network_name = "vnet-rdam-terraform-tst-001"
  resource_group_name  = var.resource_group_name
  dns_servers          = ["10.240.4.5", "10.240.4.6"]
  address_space        = ["10.0.0.0/24"]
  subnets = {

    "n-10.0.1.0_25" = {
      address_space    = "10.0.1.0/25"
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }

    "n-10.0.2.0_25" = {
      address_space    = "10.0.2.0/25"
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }

    "n-10.0.3.0_25" = {
      address_space    = "10.0.3.0/25"
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }
  }
}