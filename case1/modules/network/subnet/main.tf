resource "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  virtual_network_name = "vnet01"
  resource_group_name  = var.resource_group
  address_prefixes     = [var.subnetcidr]
  service_endpoints    =  var.subnetname == "app-subnet" ? ["Microsoft.Sql"] : []
}

