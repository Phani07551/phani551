resource "azurerm_public_ip" "public-ip" {
  name                    = "${var.vmname}-pip"
  location                = var.location
  resource_group_name     = var.resource_group
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}



resource "azurerm_network_interface" "network-interface" {
    name = var.nicname
    resource_group_name = var.resource_group
    location = var.location

    ip_configuration{
        name = var.ip
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public-ip.id
    }
}

resource "azurerm_virtual_machine" "vm" {
  name = var.vmname
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [ azurerm_network_interface.network-interface.id ]
  vm_size = "Standard_D2s_v3"
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7-LVM"
    version   = "latest"
  }

  storage_os_disk {
    name = "${var.vmname}-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "${var.vmname}-host"
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
  
  
#   resource "azurerm_availability_set" "app_availabilty_set" {
#   name                = "app_availabilty_set"
#   location            = var.location
#   resource_group_name = var.resource_group
#  }

# resource "azurerm_network_interface" "app-net-interface" {
#     name = "app-network"
#     resource_group_name = var.resource_group
#     location = var.location

#     ip_configuration{
#         name = "app-webserver"
#         subnet_id = var.app_subnet_id
#         private_ip_address_allocation = "Dynamic"
#     }
# }

# resource "azurerm_virtual_machine" "app-vm" {
#   name = "app-vm"
#   location = var.location
#   resource_group_name = var.resource_group
#   network_interface_ids = [ azurerm_network_interface.app-net-interface.id ]
#   availability_set_id = azurerm_availability_set.web_availabilty_set.id
#   vm_size = "Standard_D2s_v3"
#   delete_os_disk_on_termination = true
  
#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name = "app-disk"
#     caching = "ReadWrite"
#     create_option = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name = var.app_host_name
#     admin_username = var.app_username
#     admin_password = var.app_os_password
#   }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }