resource "azurerm_resource_group" "web" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/networking"
  sitename            = var.sitename
  resource_group_name = azurerm_resource_group.web.name
  environment         = var.environment
  location            = var.location
}

module "database" {
  source                 = "./modules/database"
  resource_group_name    = azurerm_resource_group.web.name
  location               = azurerm_resource_group.web.location
  private_dns_zone_id    = module.network.db_private_dns_zone_id
  subnet_id              = module.network.db-subnet-id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  depends_on = [module.network]
}