
module "rg2" {
  source         = "./modules/rg"
  name           = "app-rg"
  location       = var.location
}


module "app_subnet" {
  source         = "./modules/network/subnet"
  location       = var.location
  resource_group = var.rg_name
  subnetname     = var.appsubnetname
  subnetcidr     = var.appsubnetcidr
}



module "vms_app" {
  source          = "./modules/vms"
  location        = module.rg2.location_id
  resource_group  = module.rg2.name
  nicname         = "app_nic"
  ip              = "app_ip"
  subnet_id       = module.app_subnet.subnet_id
  vmname          = var.app_vmname
  username        = var.app_username
  password        = var.app_password
}

