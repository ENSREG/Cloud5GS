variable "resource_group_name" {
	description = "Resource group name"
	type        = string
}

variable "location" {
	description = "Azure region"
	type        = string
}

variable "vm_name" {
	description = "VM Name"
	default     = "cloud5gc-vm"
	type        = string
}

variable "vm_size" {
	description = "Instance size"
	default = "Standard_F8s_v2"
	type        = string
}

variable "admin_username" {
	description = "Admin username for the VM"
	default     = "ubuntu"
	type        = string
}

variable "subnet_id" {
	description = "Subnet ID"
	type        = string
}
