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

variable "nsg_name" {
  description = "Specifies the name of the network security group. Changing this forces a new resource to be created."
  type        = string 
}

variable "private_ip_address_allocation" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  type        = string
  default     = "Dynamic"
}

variable "vm_name" {
  description = "The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "vm_size" {
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

variable "license_type" {
  description = "Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  type        = string
  default     = "Windows_Server"
}

variable "secure_boot_enabled" {
  description = "Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "vtpm_enabled" {
  description = "Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "enable_automatic_updates" {
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "patch_mode" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are Manual, AutomaticByOS and AutomaticByPlatform."
  type        = string
  default     = "Manual"
}

variable "encryption_at_host_enabled" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host"
  type        = bool
  default     = true
}

variable "patch_assessment_mode" {
  description = "Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault."
  type        = string
  default     = "AutomaticByPlatform"
}

variable "source_image_id" {
  description = "The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created."
  type        = string
}

variable "caching_os_disk" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "storage_account_type_os_disk" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created."
  type        = string
  default     = "Premium_LRS"
}

variable "disk_size_os_disk" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  type        = number
  default     = 256 
}

variable "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set which should be used to Encrypt the OS or managed Disk."
  type        = string 
}

variable "data_disk_name" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_type_data_disk" {
  description = "The type of storage to use for the managed disk."
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option" {
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size" {
  description = "Specifies the size of the managed disk to create in gigabytes."
  type        = number
  default     = 32
}

variable "lun_data_disk" {
  description = "The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created."
  type        = number
  default     = 0
}

variable "caching_data_disk" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "source_image_reference" {
  description = "Settings for domain join"
  type        = map(string)

  default = {
    name     = "rotterdam.local"
    user     = "sql2022-ws2022"
    password = "sqldev-gen2"
  }
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

variable "extra_tags" {
  description = "Set the change number as a tag"
  type        = map(string)
  default     = {}
}

variable "tag_update_schedule" {
  description = "Update schedule for the resource."
  type        = string

  validation {
    condition = contains([
      "dinsdag 23:00", 
      "donderdag 00:00", 
      "maandag 23:00", 
      "vrijdag 01:00", 
      "woensdag 00:00", 
      "handmatig"
    ], var.tag_update_schedule)
    error_message = "Invalid update schedule. Allowed values: dinsdag 23:00, donderdag 00:00, maandag 23:00, vrijdag 01:00, woensdag 00:00, handmatig."
  }
}








