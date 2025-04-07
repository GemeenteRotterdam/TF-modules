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

variable "ssh_key_name" {
  description = "The name of this SSH Public Key."
  type        = string
  default     = "sshkey-rdam-linux-beheer-001"
}

variable "ssh_key_rg" {
  description = "The name of the Resource Group where the SSH Public Key exists."
  type        = string
  default     = "RG-Rdam-Linux-Beheer"
}

variable "extra_tags" {
  description = "Set the change number as a tag"
  type        = map(string)
  default     = {}
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

variable "source_image_reference" {
  description = "Source image reference for the virtual machine"
  type        = map(string)

  default = {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "94_gen2"
    version   = "latest"
  }
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "secure_boot_enabled" {
  description = "Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "patch_mode" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are Manual, AutomaticByOS and AutomaticByPlatform."
  type        = string
  default     = "ImageDefault"
}

variable "patch_assessment_mode" {
  description = "Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault."
  type        = string
  default     = "AutomaticByPlatform"
}

variable "encryption_at_host_enabled" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host"
  type        = bool
  default     = true
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
  default     = 32
}

variable "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set which should be used to Encrypt the OS or managed Disk."
  type        = string
}



