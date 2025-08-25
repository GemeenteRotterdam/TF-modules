// Context Variables

variable "resource_group_name" {
  description = "The name of the existing resource group in which to create the resource"
  type        = string
}

variable "subnet_name" {
  description = "Specifies the name of the Subnet."
  type        = string
}

variable "subnet_rg" {
  description = "Specifies the name of the resource group the Virtual Network is located in."
  type        = string
}

variable "subnet_vnet" {
  description = "Specifies the name of the Virtual Network this Subnet is located within."
  type        = string
}

variable "extra_tags" {
  description = "Set the change number as a tag"
  type        = map(string)
  default     = {}
}

// Naming Variables

variable "tenant_name" {
  description = "value"
  type        = string

  validation {
    condition     = contains(["azdev", "rdam"])
    error_message = "Tenant must be one of: 'rdam', 'azdev'."
  }
}

variable "app_name" {
  description = "value"
  type        = string
 
    validation {
    condition     = length(var.app_name) <= 8
    error_message = "Value must be 8 characters or fewer."
  }
}

variable "description" {
  description = "value"
  type        = string
  
    validation {
    condition     = length(var.description) <= 8
    error_message = "Value must be 8 characters or fewer."
  }
}

variable "environment" {
  description = "value"
  type        = string

  validation {
    condition     = contains(["sbx", "ont", "tst", "acc", "prd"])
    error_message = "Environment must be one of: 'sbx', 'ont', 'tst', 'acc', or 'prd'."
  }
}

variable "volgnr_kv" {
  description = "value"
  type        = string
}

variable "volgnr_pep" {
  description = "value"
  type        = string
}

variable "resource_azurerm_key_vault_this_name" {
  description = "Full name of the Key Vault"
  type        = string
  default     = "kv-${var.tenant_name}-${var.app_name}-${var.description}-${var.environment}-${var.volgnr_kv}"

  validation {
    condition     = can(regex("^kv-(rdam|azdev)-[a-zA-Z0-9]{1,8}-[a-zA-Z]{1,8}-(sbx|ont|tst|acc|prd)-([0][0-9]{2}|[1-9][0-9]{2})$"))
    error_message = "Failed to match Regular Expression."
  }
}

variable "resource_azurerm_private_endpoint_this_name" {
  description = "Full name of the Private Endpoint"
  type        = string
  default     = "pep-${var.tenant_name}-${var.app_name}-${var.description}-${var.environment}-${var.volgnr_pep}"

  validation {
    condition     = can(regex("^pep-(rdam|azdev)-[a-zA-Z0-9]{1,8}-[a-zA-Z]{1,8}-(sbx|ont|tst|acc|prd)-([0][0-9]{2}|[1-9][0-9]{2})$"))
    error_message = "Failed to match Regular Expression."
  }
}

// Configuration Variables

variable "sku_name" {
  description = "The pricing tier of the Key vault"
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Days to retain deleted vaults"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Enforce a mandatory retention period for deleted vaults and vault objects"
  type        = bool
  default     = true
}

variable "enabled_for_disk_encryption" {
  description = "Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  type        = bool
  default     = false
}

variable "enabled_for_deployment" {
  description = "Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  type        = bool
  default     = false
}

variable "public_network_access_enabled_kv" {
  description = "Whether public network access is allowed for this Key Vault."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  type        = bool
  default     = true
}

variable "network_acls_default_action" {
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids"
  type        = string
  default     = "Deny"
}

variable "network_acls_bypass" {
  description = "Specifies which traffic can bypass the network rules."
  type        = string
  default     = "AzureServices"
}

variable "subresource_names_kv" {
  description = "A list of subresource names which the Private Endpoint is able to connect to."
  type        = list(string)
  default     = ["Vault"]
}

variable "is_manual_connection_kv" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "private_dns_zone_name_kv" {
  description = "Name of the private dns zone group name that needs to be assigned for the key vault"
  type        = string
}

variable "private_dns_zone_id_kv" {
  description = "ID of the private dns zone group name that needs to be assigned for the key vault"
  type        = list(string)
}
