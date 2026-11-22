resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

resource "azurerm_storage_account" "storage" {
  name                     = "webstorage${random_integer.rand.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_share" "storage-fs" {
  name               = "web-share"
  storage_account_id = azurerm_storage_account.storage.id
  quota              = 50
}

resource "azurerm_recovery_services_vault" "storage_recovery_vault" {
  name                = "web-recovery-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

# resource "azurerm_backup_policy_file_share" "storage_recovery_vault_policy" {
#   name                = "web-recovery-vault-policy"
#   resource_group_name = var.resource_group_name
#   recovery_vault_name = azurerm_recovery_services_vault.storage_recovery_vault.name

#   timezone = "UTC"

#   backup {
#     frequency = "Daily"
#     time      = "23:00"
#   }

#   retention_daily {
#     count = 10
#   }

# }