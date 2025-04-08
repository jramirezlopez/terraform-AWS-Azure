
output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}
output "postgresql_subnet_id" {
  value = azurerm_subnet.postgresql.id
}
output "vnet_id" {
  value = azurerm_virtual_network.main.id
}
output "web_subnet_id" {
  value = azurerm_subnet.web.id
}

