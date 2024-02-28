resource "azurerm_resource_group" "storagerg" {
  name     = join("",["${var.prefix}"], ["RG01"])
  location = var.location
}

resource "azurerm_storage_account" "sa1" {
  name                     = lower(join("",["${var.prefix}"], ["SG01"]))
  resource_group_name      = azurerm_resource_group.storagerg.name
  location                 = azurerm_resource_group.storagerg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "testing"
  }
}