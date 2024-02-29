
resource "azurerm_resource_group" "pradeep-rg" {
  name     = var.rgname
  location = var.location
  tags = {
    Enviroment = "terraform demo"
  }
}

resource "azurerm_virtual_network" "pradeep-vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = var.vnet_cidr_prefix
  resource_group_name = azurerm_resource_group.pradeep-rg.name
  location            = azurerm_resource_group.pradeep-rg.location
}


resource "azurerm_subnet" "pradeep-subnet" {
  name                 = "${var.prefix}-subnet-5"
  resource_group_name  = azurerm_resource_group.pradeep-rg.name
  virtual_network_name = azurerm_virtual_network.pradeep-vnet.name
  address_prefixes     = var.subnet_cidr_prefix
}

resource "azurerm_public_ip" "pradeep-publicip" {
  name                = "${var.prefix}-publicip-5"
  location            = azurerm_resource_group.pradeep-rg.location
  resource_group_name = azurerm_resource_group.pradeep-rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "pradeepnsg" {
  name                = "${var.prefix}-pradeepnsg-5"
  location            = azurerm_resource_group.pradeep-rg.location
  resource_group_name = azurerm_resource_group.pradeep-rg.name

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
}

resource "azurerm_subnet_network_security_group_association" "pradeep-nsg-association" {
  subnet_id                 = azurerm_subnet.pradeep-subnet.id
  network_security_group_id = azurerm_network_security_group.pradeepnsg.id
}

resource "azurerm_network_interface" "pradeepnic" {
  name                = "${var.prefix}-pradeepnic-5"
  resource_group_name = azurerm_resource_group.pradeep-rg.name
  location            = azurerm_resource_group.pradeep-rg.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.pradeep-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pradeep-publicip.id
  }
}

resource "azurerm_linux_virtual_machine" "pradeep-vm" {
  name                            = "${var.prefix}-pradeepvm-5"
  resource_group_name             = azurerm_resource_group.pradeep-rg.name
  location                        = azurerm_resource_group.pradeep-rg.location
  size                            = var.vmconfigsize
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.pradeepnic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = var.os
    sku       = var.osversion
    version   = "latest"
  }
  os_disk {
    storage_account_type = var.storage_account_type
    caching              = "ReadWrite"
  }

  computer_name = "${var.prefix}-pradeephostvm"

  provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
  }

  connection {
    host     = self.public_ip_address
    user     = self.admin_username
    password = self.admin_password
  }
}


