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

variable "security_rule_name" {
  description = "The name of the security rule."
  type        = string
  default     = "DenyIntraSubnetTraffic"
}

variable "security_rule_description" {
  description = "A description for this rule. Restricted to 140 characters."
  type        = string
  default     = "Deny traffic between container groups in cloudshellsubnet"
}

variable "security_rule_priority" {
  description = "Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."
  type        = number
  default     = 100
}

variable "security_rule_direction" {
  description = "The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound."
  type        = string
  default     = "Inbound"
}

variable "security_rule_access" {
  description = "Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."
  type        = string
  default     = "Deny"
}

variable "security_rule_protocol" {
  description = "Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)."
  type        = string
  default     = "*"
}

variable "security_rule_source_port_range" {
  description = "Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified."
  type        = string
  default     = "*"
}

variable "security_rule_destination_port_range" {
  description = "Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified."
  type        = string
  default     = "*"
}

variable "security_rule_source_address_prefix" {
  description = "CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source_address_prefixes is not specified."
  type        = string
  default     = "*"
}

variable "security_rule_destination_address_prefix" {
  description = "CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if destination_address_prefixes is not specified."
  type        = string
  default     = "*"
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

variable "tags" {
  description = "Set the change number as a tag"
  type        = map(string)
}