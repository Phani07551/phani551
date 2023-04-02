resource "azurerm_sql_server" "sqldb" {
 #   name = "sqlserver-07551"
    name    = var.sql_name
    resource_group_name = var.resource_group
    location = var.location
    version = "12.0"
    administrator_login = var.db_admin
    administrator_login_password = var.db_password
}

resource "azurerm_sql_database" "db" {
  name                = "db"
  resource_group_name = var.resource_group
  location            = var.location
  server_name         = azurerm_sql_server.sqldb.name
}

# resource "azurerm_private_endpoint" "db_private_endpoint" {
#   name                = "db-private-endpoint"
#   location            =  var.location
#   resource_group_name = var.resource_group
#   subnet_id           = var.subnet_id

#   private_service_connection {
#     name                           = "db-private-serviceconnection"
#     private_connection_resource_id = azurerm_sql_server.sqldb.id
#     subresource_names              = [ "sqlServer" ]
# #     is_manual_connection           = false
# #   }
# }

data "azurerm_subnet" "app_subnet" {
  name                 = "app-subnet"
  virtual_network_name = "vnet01"
  resource_group_name  = "vnet-rg"
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                = "sql-vnet-rule"
  resource_group_name = var.resource_group
  server_name         = azurerm_sql_server.sqldb.name
  subnet_id           = data.azurerm_subnet.app_subnet.id
}