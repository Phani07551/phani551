module "rg" {
  source         = "./modules/rg"
  name           = var.rg_name
  location       = var.location
}


module "vnet" {
  source         = "./modules/network/vnet"
  location       = module.rg.location_id
  resource_group = var.rg_name
  vnetcidr       = var.vnetcidr
}
