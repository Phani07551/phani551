module "rg3" {
  source         = "./modules/rg"
  name           = "db-rg"
  location       = var.location
}

module "db_subnet" {
  source         = "./modules/network/subnet"
  location       = var.location
  resource_group = var.rg_name
  subnetname     = var.dbsubnetname
  subnetcidr     = var.dbsubnetcidr
}


module "database" {
  source            = "./modules/db"
  sql_name          = var.sqlname
  location          = module.rg3.location_id
  resource_group    = module.rg3.name
  db_admin          = var.database_admin
  db_password       = var.database_password
  subnet_id         = module.db_subnet.subnet_id
}