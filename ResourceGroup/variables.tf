variable "name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource group"
  type = object({
    backup                  = optional(string)
    change_number           = optional(string)
    classification          = optional(string)
    clustername             = optional(string)
    department              = optional(string)
    disaster_recovery       = optional(string)
    environment             = optional(string)
    "business financial id" = optional(string)
    financial_id            = optional(string)
    functional              = optional(string)
    operation_team          = optional(string)
    owner                   = optional(string)
    shared                  = optional(string)
    short_name              = optional(string)
    tasknumber_projects     = optional(string)
  })
  default = {}
}

variable "user_assigned_identity_id" {
  description = "ID of the managed Identity where the federated credential will be set."
  type        = string
}
