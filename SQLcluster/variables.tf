variable "resource_group_name" {
  description = "The name of the existing resource group in which to create the resource"
  type        = string
}

variable "existing_vnet_name" {
  default = "Name of the existing Vnet"
  type    = string 
}

variable "existing_vnet_rg" {
  default = "Resource group name of the existing Vnet"
  type    = string 
}

variable "existing_subnet_name" {
  description = "Specifies the name of the Subnet."
  type        = string
}

variable "NSG_name" {
  description = "Specifies the name of the network security group. Changing this forces a new resource to be created."
  type        = string 
}

variable "private_ip_address_allocation1" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  type        = string
  default     = "Dynamic"
}

variable "vm_name1" {
  description = "The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "vm_size1" {
  description = "The SKU which should be used for this Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  type        = string 
}

variable "admin_password" {
  description = "The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
  type        = string 
}
variable "license_type1" {
  description = "Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  type        = string
  default     = "Windows_Server"
}

variable "secure_boot_enabled1" {
  description = "Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "vtpm_enabled1" {
  description = "Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "enable_automatic_updates1" {
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "patch_mode1" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are Manual, AutomaticByOS and AutomaticByPlatform."
  type        = string
  default     = "Manual"
}

variable "encryption_at_host_enabled1" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host"
  type        = bool
  default     = true
}

variable "patch_assessment_mode1" {
  description = "Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault."
  type        = string
  default     = "AutomaticByPlatform"
}

variable "source_image_id1" {
  description = "The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created."
  type        = string
}

variable "caching_os_disk1" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "storage_account_type_os_disk1" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created."
  type        = string
  default     = "Premium_LRS"
}

variable "disk_size_os_disk1" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  type        = number
  default     = 256 
}

variable "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set which should be used to Encrypt the OS or managed Disk."
  type        = string 
}

variable "data_disk_name1" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk1" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option1" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size1" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 32
}

variable "lun_data_disk1" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 0
}

variable "caching_data_disk1" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "data_disk_name2" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk2" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option2" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size2" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 1024
}

variable "lun_data_disk2" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 1
}

variable "caching_data_disk2" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "data_disk_name3" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk3" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option3" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size3" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 1024
}

variable "lun_data_disk3" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 2
}

variable "caching_data_disk3" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "data_disk_name4" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk4" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option4" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size4" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 32
}

variable "lun_data_disk4" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 3
}

variable "caching_data_disk4" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "private_ip_address_allocation2" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  type        = string
  default     = "Dynamic"
}

variable "vm_name2" {
  description = "The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "vm_size2" {
  description = "The SKU which should be used for this Virtual Machine"
  type        = string
}

variable "license_type2" {
  description = "Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  type        = string
  default     = "Windows_Server"
}

variable "secure_boot_enabled2" {
  description = "Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "vtpm_enabled2" {
  description = "Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "enable_automatic_updates2" {
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "patch_mode2" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are Manual, AutomaticByOS and AutomaticByPlatform."
  type        = string
  default     = "Manual"
}

variable "encryption_at_host_enabled2" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host"
  type        = bool
  default     = true
}

variable "patch_assessment_mode2" {
  description = "Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault."
  type        = string
  default     = "AutomaticByPlatform"
}

variable "source_image_id2" {
  description = "The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created."
  type        = string
}

variable "caching_os_disk2" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "storage_account_type_os_disk2" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created."
  type        = string
  default     = "Premium_LRS"
}

variable "disk_size_os_disk2" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  type        = number
  default     = 256 
}

variable "data_disk_name5" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk5" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option5" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size5" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 32
}

variable "lun_data_disk5" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 0
}

variable "caching_data_disk5" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "data_disk_name6" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk6" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option6" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size6" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 1024
}

variable "lun_data_disk6" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 1
}

variable "caching_data_disk6" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "data_disk_name7" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk7" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option7" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size7" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 1024
}

variable "lun_data_disk7" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 2
}

variable "caching_data_disk7" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "data_disk_name8" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk8" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option8" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size8" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 32
}

variable "lun_data_disk8" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 3
}

variable "caching_data_disk8" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

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

variable "private_dns_zone_name_kv"{
  description = "Name of the private dns zone group name that needs to be assigned for the key vault"
  type        = string
}

variable "private_dns_zone_id_kv"{
  description = "ID of the private dns zone group name that needs to be assigned for the key vault"
  type        = list(string) 
}

variable "private_dns_zone_name_sa"{
  description = "Name of the private dns zone group name that needs to be assigned for the storage account"
  type        = string
}

variable "private_dns_zone_id_sa"{
  description = "ID of the private dns zone group name that needs to be assigned for the storage account"
  type        = list(string) 
}

variable "tags" {
  description = "Set the change number as a tag"
  type        = map(string)
}

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

variable "private_endpoint_name_for_sa" {
  description = "The name of the private endpoint"
  type        = string
}

variable "subresource_names_sa" {
  description = "A list of subresource names which the Private Endpoint is able to connect to."
  type        = list(string)
  default     = ["Blob"]
}

variable "is_manual_connection_sa" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "identity_name" {
  description = "The name of the identity that is going to be created"
  type        = string 
}

variable "keyvault_key_name" {
  description = "The name of the key vault that is going to be created"
  type        = string 
}

variable "storage_share_name" {
  description = "The name of the share. Must be unique within the storage account where the share is located. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_share_quota" {
  description = "The maximum size of the share, in gigabytes."
  type        = number
  default     = 5
}

variable "OU_path" {
  description = "The Organizational Unit (OU) path for the server"
  type        = string
  //default     = "OU=Management servers,OU=Servers,DC=rotterdam,DC=local"

  validation {
    condition     = can(regex("^OU=.*DC=.*$", var.OU_path))
    error_message = "The OU Path must start with 'OU=' and contain 'DC=' components."
  }
}