output "vnet_id" {
	description = "Created virtual network ID"
	value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
	description = "Created subnet ID"
	value       = azurerm_subnet.subnet.id
}
