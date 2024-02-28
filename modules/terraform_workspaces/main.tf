resource "azurerm_resource_group" "workspacerg" {
    name = "${var.prefix}-workspaces"
    location = var.location
    tags = {
      owner = "pradeep"
    }
  
}