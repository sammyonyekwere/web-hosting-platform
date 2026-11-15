output "vnet-id" {
  value = azurerm_virtual_network.network.id
}

output "app-subnet-id" {
  value = azurerm_subnet.app.id
}

output "db-subnet-id" {
  value = azurerm_subnet.db.id
}

output "db_private_dns_zone" {
  value = azurerm_private_dns_zone.db.id
}