variable "prefix" {
  description = "prefix name used for all resources"
  type        = string
}

variable "subnet_cidr_prefix" {
  description = "subnet cidr ranges"
  type = list(string)
}

variable "vnet_cidr_prefix" {
    description = "vnet cidr ranges"
  type = list(string)
}

variable "rgname" {
    description = "resource group name"
    type = string
  
}

variable "location" {
    description = "location of the resources"
    type = string
  
}

variable "vmconfigsize" {
    description = "vmcongisize"
    type = string

}

variable "username" {
    description = "login user name"
    type = string
  
}

variable "password" {
    description = "login user password"
    type = string
  
}



variable "os" {
    description = "type of os"
type = string
}

variable "osversion" {
    description = "os version"
    type = string
  
}

variable "storage_account_type" {
    type = string
    description = "storage account description"
  
}
