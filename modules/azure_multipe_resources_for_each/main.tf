resource "azurerm_resource_group" "eachrg" {
  for_each = var.resourcedetails
  name     = each.value.rg_name
  location = each.value.location
}


resource "azurerm_virtual_network" "eachnet" {
  for_each = var.resourcedetails

  name                = each.value.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.eachrg[each.key].location
  resource_group_name = azurerm_resource_group.eachrg[each.key].name
}

resource "azurerm_subnet" "eachsubnet" {
  for_each = var.resourcedetails

  name                 = each.value.subnet_name
  address_prefixes     = ["10.0.0.0/24"]
  virtual_network_name = azurerm_virtual_network.eachnet[each.key].name
  resource_group_name  = azurerm_resource_group.eachrg[each.key].name

}

resource "azurerm_network_interface" "eachnic" {
  for_each = var.resourcedetails

  name                = "eachnic"
  location            = azurerm_resource_group.eachrg[each.key].location
  resource_group_name = azurerm_resource_group.eachrg[each.key].name

  ip_configuration {
    name                          = "eachconfig"
    subnet_id                     = azurerm_subnet.eachsubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "eachvm" {
  for_each = var.resourcedetails

  name                  = each.value.name
  location              = azurerm_resource_group.eachrg[each.key].location
  resource_group_name   = azurerm_resource_group.eachrg[each.key].name
  network_interface_ids = [azurerm_network_interface.eachnic[each.key].id]
  vm_size               = each.value.size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${each.value.name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"

  }

  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true
  os_profile {
    computer_name  = each.value.name
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }


}

