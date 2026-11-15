output "fqdn" {
  value = azurerm_mysql_flexible_server.db.fqdn
}

output "database_name" {
  value = azurerm_mysql_flexible_database.db.name
}