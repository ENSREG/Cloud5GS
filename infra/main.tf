terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = random_pet.rg_name.id
}

# Reference virtual network configuration
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
}

# Reference virtual machine configuration
module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  subnet_id           = module.network.subnet_id
}
