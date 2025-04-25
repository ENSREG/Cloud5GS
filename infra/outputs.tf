output "vm_public_ip" {
	description = "Virtual Machine's public IP"
	value       = module.vm.vm_public_ip
}

output "vm_private_ip" {
	description = "Virtual Machine's private IP"
	value       = module.vm.vm_private_ip
}

output "resource_group_name" {
	description = "Created resource group name"
	value       = azurerm_resource_group.rg.name
}

output "vnet_name" {
	description = "Virtual Network Name"
	value       = var.vnet_name
}
