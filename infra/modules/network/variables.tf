variable "resource_group_name" {
	description = "Resource group name"
	type        = string
}

variable "location" {
	description = "Azure region"
	type        = string
}

variable "vnet_name" {
	description = "Virtual network name"
	type        = string
}

variable "subnet_name" {
	description = "Subnet name"
	type        = string
}

variable "address_space" {
	description = "Virtual network address space"
	type        = list(string)
}

variable "subnet_prefixes" {
	description = "Subnet address range"
	type        = list(string)
}
