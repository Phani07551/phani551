
variable "rg_name" {
}
variable "location" {
}
variable "vnetcidr" {
}

# Web layer
variable "websubnetcidr" {
}
variable "websubnetname" {
}

# variable "web_rg_name" {
# }

variable "web_vmname" {
}

variable "web_username" {
}

variable "web_password" {
}

# App Layer
variable "appsubnetcidr" {
}
variable "appsubnetname" {
}

variable "app_vmname" {
}

variable "app_username" {
}

variable "app_password" {
}



# DB Layer
variable "dbsubnetcidr" {
}
variable "dbsubnetname" {
}

variable "database_admin" {
}
variable "database_password" {
}
variable "sqlname" {
}




variable "app_resource_group" {
}

variable "db_resource_group" {
}
