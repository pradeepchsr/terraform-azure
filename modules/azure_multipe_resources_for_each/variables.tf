variable "resourcedetails" {
  type = map(object({
    name        = string
    location    = string
    size        = string
    rg_name     = string
    vnet_name   = string
    subnet_name = string
  }))

  default = {
    "Central India" = {
      rg_name     = "CentralIndiarg"
      name        = "each-vm-ci"
      location    = "CentralIndia"
      size        = "Standard_B1s"
      vnet_name   = "eachvnet-1"
      subnet_name = "eachsubnet"
    }

    # eastus = {
    #   rg_name     = "eastusrg"
    #   name        = "each-vm-east"
    #   location    = "eastus"
    #   size        = "Standard_B1s"
    #   vnet_name   = "eachvnet-2"
    #   subnet_name = "eachsubnet-2"
    # }

    # westus = {
    #   rg_name     = "westusrg"
    #   name        = "each-vm-west"
    #   location    = "westus"
    #   size        = "Standard_B1s"
    #   vnet_name   = "eachvnet-3"
    #   subnet_name = "eachsubnet-3"
    # }
  }

}