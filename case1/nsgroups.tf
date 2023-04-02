module "securitygroup" {
  source         = "./modules/nsg"
  location       = module.rg1.location_id
  resource_group = module.rg1.name 
  subnet_id      = module.web_subnet.subnet_id

  
  app_resource_group  = var.app_resource_group
  app_subnet_id  = module.app_subnet.subnet_id
  
  db_resource_group  = var.db_resource_group
  db_subnet_id  = module.db_subnet.subnet_id
}