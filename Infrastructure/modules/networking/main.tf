resource "azurerm_virtual_network" "network" {
  name                = "vnet-web-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.20.0.0/16"]

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.20.1.0/24"]

  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_subnet" "db" {
  name                 = "snet-db"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.20.2.0/24"]

  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
    }
  }
}

resource "azurerm_private_dns_zone" "db" {
  name                = "${var.sitename}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "db" {
  name                = "mysql-vnet-link"
  private_dns_zone_id = azurerm_private_dns_zone.db.id
  virtual_network_id  = azurerm_virtual_network.network.id

  registration_enabled = false
}