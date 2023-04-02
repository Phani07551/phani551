resource "azurerm_network_security_group" "nsg" {
  name                = "web-nsg" 
  location            = var.location
  resource_group_name = var.resource_group
  
  security_rule {
    name                       = "ssh-rule"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }
  
  security_rule {
        name                       = "http"
        priority                   = 201
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

  security_rule {
        name                       = "https"
        priority                   = 301
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
}

resource "azurerm_subnet_network_security_group_association" "nsg-subnet" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# App NSG

resource "azurerm_network_security_group" "app-nsg" {
  name                = "app-nsg" 
  location            = var.location
  resource_group_name = var.app_resource_group
  
  security_rule {
    name                       = "ssh-rule"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }

  security_rule {
        name                       = "app_rule"
        priority                   = 201
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "10.0.0.0/24"
        destination_address_prefix = "*"
      }
}

resource "azurerm_subnet_network_security_group_association" "nsg-appsubnet" {
  subnet_id                 =  var.app_subnet_id
  network_security_group_id = azurerm_network_security_group.app-nsg.id
}


# # db
# resource "azurerm_network_security_group" "db-nsg" {
#     name = "db-nsg"
#     location = var.location
#     resource_group_name = var.db_resource_group

#     security_rule {
#         name = "ssh-rule-1"
#         priority = 101
#         direction = "Inbound"
#         access = "Allow"
#         protocol = "Tcp"
#         source_address_prefix = "10.0.1.0/24"
#         source_port_range = "*"
#         destination_address_prefix = "*"
#         destination_port_range = "1433"
#     }
# }

# resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
#   subnet_id                 = var.db_subnet_id
#   network_security_group_id = azurerm_network_security_group.db-nsg.id
# }

