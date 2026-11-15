resource "azurerm_mysql_flexible_server" "db" {
  name                   = "db-flexible-server"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  backup_retention_days  = 7
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = var.private_dns_zone_id
  sku_name               = "B_Standard_B1ms"
  version                = 8.4
  public_network_access  = "Disabled"

}

resource "azurerm_mysql_flexible_server_configuration" "db_tls_version" {
  name                = "tls_version"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.db.name
  value               = "TLSv1.2"
}

resource "azurerm_mysql_flexible_database" "db" {
  name                = "webdb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.db.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}