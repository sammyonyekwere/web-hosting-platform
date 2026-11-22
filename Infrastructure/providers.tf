terraform {
  required_version = "~>1.16"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "azurerm" {
    use_oidc             = true
    use_azuread_auth     = true
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}