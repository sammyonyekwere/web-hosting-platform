resource "azurerm_resource_group" "example" {
  name     = "rg-web-prod"
  location = var.location
}

module "network" {
  source              = "./modules/networking"
  sitename            = var.sitename
  resource_group_name = var.resource_group_name
  environment         = var.environment
  location            = var.location
}