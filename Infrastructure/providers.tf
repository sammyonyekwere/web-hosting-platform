terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-web-tfstate"
    storage_account_name = "sttfstate20923" # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"
    key                  = "php-prod.tfstate"
    use_oidc             = true
    use_azuread_auth     = true
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}