output "vm_id" {
	description = "Virtual machine ID"
	value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_public_ip" {
	description = "Virtual machine public IP"
	value       = azurerm_public_ip.public_ip.ip_address
}

output "vm_private_ip" {
	description = "Virtual machine private IP"
	value       = azurerm_network_interface.nic.private_ip_address
}
