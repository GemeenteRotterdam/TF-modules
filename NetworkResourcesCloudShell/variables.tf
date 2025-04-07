variable "azure_container_service_name" {
  description = "value"
  type        = string
  default     = "Azure Container Instance Service"
}

variable "vnet_name" {
  description = "The name of the existing Vnet"
  type        = string
}

variable "vnet_rg" {
  description = "The resource group where the existing Vnet is in"
  type        = string
}

variable "private_dns_zone_group_name" {
  description = "Specifies the Name of the Private DNS Zone Group for key vault."
  type        = string
}

variable "private_dns_zone_ids" {
  description = "Specifies the list of Private DNS Zones to include within the private_dns_zone_group."
  type        = list(string)
}

variable "nsg_name" {
  description = "Specifies the name of the network security group. Changing this forces a new resource to be created."
  type        = string
}

variable "security_rule" {
  description = "Security rule configuration for the network security group."
  type        = map(string)

  default = {
    name                       = "DenyIntraSubnetTraffic"
    description                = "Deny traffic between container groups in cloudshellsubnet"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

variable "container_subnet_name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
  type        = string
}

variable "container_subnet_address_prefix" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

variable "network_profile_name" {
  description = "Specifies the name of the Network Profile. Changing this forces a new resource to be created."
  type        = string
}

variable "relay_namespace_name" {
  description = "Specifies the name of the Azure Relay Namespace. Changing this forces a new resource to be created."
  type        = string
}

variable "relay_namespace_sku" {
  description = "The name of the SKU to use. At this time the only supported value is Standard."
  type        = string
  default     = "Standard"
}

variable "relay_subnet_name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
  type        = string
}

variable "relay_subnet_address_prefix" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

variable "storage_subnet_name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
  type        = string
}

variable "private_endpoint_name" {
  description = "Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created."
  type        = string
}

variable "private_endpoint_is_manual_connection" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "private_endpoint_subresources_names" {
  description = "A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. Possible values are detailed in the product documentation in the Subresources column. Changing this forces a new resource to be created."
  type        = list(string)
  default     = ["namespace"]
}

variable "storage_subnet_address_prefix" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

variable "extra_tags" {
  description = "Set the change number as a tag"
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "The name of the existing resource group in which to create the resource"
  type        = string
}