terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "pradeep_rg1"{
  name = "pradeep-compute"
  location = "West Europe"
}
resource "azurerm_resource_group" "pradeep_rg2"{
  name = "pradeep-vpc"
  location = "West Europe"
}

resource "azurerm_virtual_network" "myvpc" {
name = "vpc1"
address_space = ["10.0.0.0/16"]
resource_group_name = azurerm_resource_group.pradeep_rg2.name
location = "West Europe"
}

resource "azurerm_virtual_network" "myvpc2" {
name = "pradeep-vpc2"
address_space = ["10.0.0.0/16"]
resource_group_name = azurerm_resource_group.pradeep_rg2.name
location = "Central India"
}


resource "azurerm_subnet" "mysubnet" {
  name = "vpc1-subnet1"
  resource_group_name = azurerm_resource_group.pradeep_rg2.name
  virtual_network_name = azurerm_virtual_network.myvpc.name
  address_prefixes =  ["10.0.3.0/24"]
}


resource "azurerm_subnet" "defaultsubnet" {
  name = "default"
  resource_group_name = azurerm_resource_group.pradeep_rg2.name
  virtual_network_name = azurerm_virtual_network.myvpc.name
  address_prefixes =  ["10.0.0.0/24"]
}

resource "azurerm_subnet" "mysubnet2" {
  name = "vpc1-subnet2"
  resource_group_name = azurerm_resource_group.pradeep_rg2.name
  virtual_network_name = azurerm_virtual_network.myvpc.name
  address_prefixes =  ["10.0.1.0/24"]
}


resource "azurerm_network_security_group" "vmnsg" {
  name                = "pradeep-vm1-nsg"
  location            = azurerm_resource_group.pradeep_rg1.location
  resource_group_name = azurerm_resource_group.pradeep_rg1.name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # tags = {
  #   environment = "Production"
  # }
}

# resource "azurerm_ssh_public_key" "vmkey" {
#   name                = "pradeep-vm1-key"
#   resource_group_name = azurerm_resource_group.pradeep_rg1.name
#   location            = azurerm_resource_group.pradeep_rg1.location
#   public_key          = file("C:/Users/PradeepChittoor/id_rsa.pub")
# }