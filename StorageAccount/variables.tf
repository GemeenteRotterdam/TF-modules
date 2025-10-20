variable "resource_group_name" {
  description = "The name of the resource group in which to create the resource"
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

//KeyVault variables
variable "keyvault_name" {
  description = "The name of the Key Vault"
  type        = string
}

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

variable "role_definition_name_kv" {
  description = "The name of a built-in key vault role."
  type        = string
  default     = "Key Vault Administrator"
}

//Private endpoint for Key vault variables
variable "private_endpoint_name_for_kv" {
  description = "The name of the private endpoint"
  type        = string
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

variable "private_dns_zone_name_sa" {
  description = "Name of the private dns zone group name that needs to be assigned for the storage account"
  type        = string
}

variable "private_dns_zone_id_sa" {
  description = "ID of the private dns zone group name that needs to be assigned for the storage account"
  type        = list(string)
}

//Managed identity variables
variable "identity_name" {
  description = "The name of the identity that is going to be created"
  type        = string
}

variable "role_definition_name_mi" {
  description = "The name of a built-in managed identity role."
  type        = string
  default     = "Key Vault Crypto Service Encryption User"
}

//Key vault key variables
variable "keyvault_key_name" {
  description = "The name of the key vault that is going to be created"
  type        = string
}

variable "key_type" {
  description = "Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM."
  type        = string
  default     = "RSA"
}

variable "key_size" {
  description = "Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM"
  type        = number
  default     = 2048
}

variable "key_opts" {
  description = "A list of JSON web key operations. Possible values include: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. Please note these values are case sensitive."
  type        = list(string)
  default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}

variable "time_before_expiry" {
  description = "Rotate automatically at a duration before expiry as an ISO 8601 duration."
  type        = string
  default     = "P7D"
}

variable "notify_before_expiry" {
  description = "Notify at a given duration before expiry as an ISO 8601 duration."
  type        = string
  default     = "P30D"
}

variable "expire_after" {
  description = "Expire a Key Vault Key after given duration as an ISO 8601 duration."
  type        = string
  default     = "P90D"
}

//Storage Account variables
variable "storage_account_name" {
  description = "The Name of the Storage Account"
  type        = string
}

variable "storage_account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid."
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string
  default     = "LRS"
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD)."
  type        = bool
  default     = true
}

variable "public_network_access_enabled_sa" {
  description = "Whether the public network access is enabled?"
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled?"
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public."
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = "Should cross Tenant replication be enabled?"
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned"
  type        = string
  default     = "UserAssigned"
}

variable "network_rules_default_action" {
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids"
  type        = string
  default     = "Deny"
}

variable "network_rules_bypass" {
  description = "Specifies which traffic can bypass the network rules."
  type        = list(string)
  default     = ["AzureServices"]
}

variable "blob_delete_retention_policy" {
  description = "Specifies the number of days that the blob should be retained, between 1 and 365 days."
  type        = number
  default     = 7
}

variable "container_delete_retention_policy" {
  description = "Specifies the number of days that the container should be retained, between 1 and 365 days."
  type        = number
  default     = 7
}

//Private endpoint for Storage Account variables
variable "private_endpoint_name_for_sa" {
  description = "The name of the private endpoint"
  type        = string
}

variable "subresource_names_sa" {
  description = "A list of subresource names which the Private Endpoint is able to connect to."
  type        = list(string)
  default     = ["File"]
}

variable "is_manual_connection_sa" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "dns_suffix" {
  description = "The DNS suffix for Azure Key Vaults (default: vault.azure.net)"
  type        = string
  default     = "vault.azure.net"
}


