# variable "subscription_id" {
#   description = "value"
#   type        = string 
# }

# variable "tenant_id" {
#   description = "value"
#   type        = string 
# }

variable "resource_group_name" {
  description = "value"
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "value"
  type        = string
  default     = ""
}

variable "subnet_rg" {
  description = "value"
  type        = string
  default     = ""
}

variable "subnet_vnet" {
  description = "value"
  type        = string
  default     = ""
}

//variable "secret_username_name" {
//  description = "value"
//  type        = string
//  default     = ""
//}

//variable "key_vault_id_secret_username" {
//  description = "value"
//  type        = string
//  default     = ""
//}

//variable "secret_password_name" {
//  description = "value"
//  type        = string
//  default     = ""
//}

//variable "key_vault_id_secret_password" {
//  description = "value"
//  type        = string
//  default     = ""
//}

variable "NSG_name" {
  description = "value"
  type        = string 
}

variable "disk_encryption_set_name" {
  description = "value"
  type        = string
  default     = "des-rdam-hus-test-002"
}

variable "disk_encryption_set_rg" {
  description = "value"
  type        = string
  default     = "RG-rdam-test-hus-P"
}

variable "private_ip_address_allocation" {
  description = "value"
  type        = string
  default     = "Dynamic"
}

variable "vm_name" {
  description = "value"
  type        = string
}

variable "vm_size" {
  description = "value"
  type        = string
}

variable "license_type" {
  description = "value"
  type        = string
  default     = "Windows_Server"
}

variable "secure_boot_enabled" {
  description = "value"
  type        = bool
  default     = true
}

variable "vtpm_enabled" {
  description = "value"
  type        = bool
  default     = true
}

variable "enable_automatic_updates" {
  description = "value"
  type        = bool
  default     = false
}

variable "patch_mode" {
  description = "value"
  type        = string
  default     = "Manual"
}

variable "encryption_at_host_enabled" {
  description = "value"
  type        = bool
  default     = true
}

variable "patch_assessment_mode" {
  description = "value"
  type        = string
  default     = "AutomaticByPlatform"
}

variable "source_image_id" {
  description = "value"
  type        = string
}

variable "caching_os_disk" {
  description = "value"
  type        = string
  default     = "ReadWrite"
}

variable "storage_account_type_os_disk" {
  description = "value"
  type        = string
  default     = "Premium_LRS"
}

variable "data_disk_name" {
  description = "value"
  type        = string
}

variable "storage_account_type_data_disk" {
  description = "value"
  type        = string
  default     = "Premium_LRS"
}

variable "managed_disk_create_option" {
  description = "value"
  type        = string
  default     = "Empty"
}

variable "managed_disk_size" {
  description = "value"
  type        = number
  default     = 32
}

variable "lun_data_disk" {
  description = "value"
  type        = number
  default     = 0
}

variable "caching_data_disk" {
  description = "value"
  type        = string
  default     = "ReadWrite"
}

variable "OU_path" {
  description = "value"
  type        = string
}

variable "OU_description" {
  description = "value"
  type        = string
}

variable "tag_changenumber" {
  description = "value"
  type        = string
}







