
module "rg1" {
  source         = "./modules/rg"
  name           = "web-rg"
  location       = var.location
}


module "web_subnet" {
  source         = "./modules/network/subnet"
  location       = var.location
  resource_group = var.rg_name
  subnetname     = var.websubnetname
  subnetcidr     = var.websubnetcidr
}



module "vms" {
  source          = "./modules/vms"
  location        = module.rg1.location_id
  resource_group  = module.rg1.name
  nicname         = "web_nic"
  ip              = "web_ip"
  subnet_id       = module.web_subnet.subnet_id
  vmname          = var.web_vmname
  username        = var.web_username
  password        = var.web_password
}

