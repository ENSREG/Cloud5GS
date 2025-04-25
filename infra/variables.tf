variable "resource_group_name_prefix" {
  type        = string
  default     = "cloud5gc-rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "location" {
	description = "Azure region"
	type        = string
	default     = "eastasia"
}

variable "vnet_name" {
	description = "Virtual Network Name"
	type        = string
	default     = "cloud5gc-vnet"
}

variable "subnet_name" {
	description = "Subnet Name"
	type        = string
	default     = "cloud5gc-subnet"
}

variable "address_space" {
	description = "Virtual Network Address Space"
	type        = list(string)
	default     = ["172.18.0.0/16"]
}

variable "subnet_prefixes" {
	description = "Subnet Address Range"
	type        = list(string)
	default     = ["172.18.1.0/24"]
}

variable "vm_name" {
	description = "Virtual Machine Name"
	type        = string
	default     = "cloud5gc-vm"
}

variable "vm_size" {
	description = "Instance Size"
	type        = string
	default     = "Standard_F8s_v2"
}

variable "admin_username" {
	description = "Admin Username for the VM"
	type        = string
	default     = "ubuntu"
}
