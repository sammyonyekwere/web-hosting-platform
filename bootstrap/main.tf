
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }

  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {

}

# data "azurerm_resource_group" "name" {
#   name = "rg-web-tfstate"
# }

resource "random_integer" "tfstate" {
  min = 100
  max = 50000
}


# Create a resource group
resource "azurerm_resource_group" "state" {
  name     = "rg-web-tfstate"
  location = "UK South"

}

resource "azurerm_storage_account" "state" {
  name                     = "sttfstate${random_integer.tfstate.result}"
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }
  tags = {
    environment = "state"
  }
}

resource "azurerm_storage_container" "state" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.state.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "state" {
  name                 = "tfstate-blob"
  storage_container_id = azurerm_storage_container.state.id
  type                 = "Block"
}




//////////////////////////////////////
## Assign the  Storage Blob Data Contributor 
## to the infrastructure GitHub identity 
## on the tfstate container
resource "azuread_application" "github" {
  display_name = "github-infrastructure"
}
resource "azuread_service_principal" "github" {
  client_id = azuread_application.github.client_id
}

resource "azuread_application_federated_identity_credential" "github" {
  application_id = azuread_application.github.id

  display_name = "github-main"
  description  = "GitHub Actions"

  audiences = ["api://AzureADTokenExchange"]

  issuer  = "https://token.actions.githubusercontent.com"
  subject = "repo:${var.github_repo}:ref:refs/heads/main"
}

resource "azurerm_role_assignment" "github" {
  scope                = azurerm_storage_container.state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.github.object_id

}


output "random_integer" {
  value = random_integer.tfstate.result
}