variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
  validation {
    condition     = can(regex("^vnet-(rdam|azdev)-[a-z0-9]{1,16}-[a-z]{1,16}-[0-9]{3}$", var.virtual_network_name))
    error_message = "Failed To Match Naming Convention"
  }
}

variable "dns_servers" {
  description = "The addresses of the DNS servers"
  type        = list(any)
}

variable "pep_policy" {
  description = "The main IPv4 address space"
  default     = "Disabled"
  type        = string
}

variable "address_space" {
  description = "The main IPv4 address space"
  type        = list(any)
}

variable "subnets" {
  type = map(object({
    address_space               = list(string)
    service_endpoint_policy_ids = optional(list(string))
    service_endpoints           = optional(list(string))

    }
    )
  )
}
