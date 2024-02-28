# output "prefix_check" {
#     value = join("",["${var.prefix}"], ["RG01"])
# }

output "rgname" {
    value = azurerm_resource_group.storagerg.name
    description = "rgname description"
}

output "sa1" {
    value = azurerm_storage_account.sa1.name
}