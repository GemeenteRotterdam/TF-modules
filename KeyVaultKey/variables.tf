variable "key_name" {
    description = "The name of the key."
    type        = string  
}

variable "key_type" {
    description = "The type of key to create."
    type        = string
    default     = "RSA"  
}

variable "key_size" {
    description = "The byte size of key to create."
    type        = number
    default     = 2048
}

variable "key_opts" {
    description = "Allowed JSON operations."
    type        = list(string)
    default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey",]
}

variable "key_lifetime" {
    description = "Number of days the key will be valid before expiry."
    type        = string
    default     = "P90D"  
}

variable "key_notification" {
    description = "Number of days to notify in advance of key expiry."
    type        = string
    default     = "P30D"  
}

variable "key_rotation" {
    description = "Number of days to rotate key in advance of expiry."
    type        = string
    default     = "P30D"  
}

variable "keyvault_name" {
    description = "The name of the key vault the key belongs to."
    type        = string  
}

variable "resource_group_name" {
    description = "The name of the resource group the keyvault belongs to."
    type        = string  
}
