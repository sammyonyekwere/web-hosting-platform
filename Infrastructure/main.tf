resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

data "azurerm_resource_group" "web" {
  name = var.resource_group_name
}

module "network" {
  source              = "./modules/networking"
  sitename            = var.app_name
  resource_group_name = data.azurerm_resource_group.web.name
  environment         = var.environment
  location            = var.location
}

module "database" {
  source                 = "./modules/database"
  resource_group_name    = data.azurerm_resource_group.web.name
  location               = data.azurerm_resource_group.web.location
  private_dns_zone_id    = module.network.db_private_dns_zone_id
  subnet_id              = module.network.db-subnet-id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  depends_on = [module.network]
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = data.azurerm_resource_group.web.name
  location            = data.azurerm_resource_group.web.location


}

module "hosting" {
  source               = "./modules/hosting"
  app_name             = "${var.app_name}${random_integer.rand.result}"
  app_email            = var.app_email
  resource_group_name  = data.azurerm_resource_group.web.name
  location             = data.azurerm_resource_group.web.location
  database_name        = module.database.database_name
  database_hostname    = module.database.fqdn
  storage_access_key   = module.storage.storage_access_key
  storage_account_name = module.storage.storage_account_name
  storage_share_name   = module.storage.storage_file_share_name
  subnet_id            = module.network.app-subnet-id
}