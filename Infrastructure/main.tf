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