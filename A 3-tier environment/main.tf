terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}  

  subscription_id = "2caed41f-1ca1-4185-9bcd-865ff041c13a"
  client_id       = "920a3535-5642-4c1b-b087-abfa4c9794ae"
  client_secret   = "lJt8Q~6TnYB~c.Zb8GgSFSKoRdYsztOtCC-hubS7"
  tenant_id       = "0538670b-9fae-44b9-9caa-c4100d7ffb95"


}

/// code here 

resource "azurerm_resource_group" "rg" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.prefix}-10"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  address_space       = ["${var.vnet_cidr_prefix}"]
}

resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefixes     = ["10.0.1.0/24"] //["${var.subnet1_cidr_prefix}"]
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_machine" "web" {
  name                  = "web-vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  vm_size                         = "Standard_DS2_v2"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssword@12345"
  network_interface_ids = [ azurerm_network_interface.nic1.id ]


  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2012-R2-Datacenter"
#     version   = "latest"
#   }

  storage_os_disk {
    name              = "web-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "web-vm"
    admin_username = "adminUser"
    admin_password = "password123!"
  }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
}

# Similar resource definitions for app-vm and db-vm
