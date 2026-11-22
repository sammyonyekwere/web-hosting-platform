output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}

output "storage_file_share_id" {
  value = azurerm_storage_share.storage-fs.id
}

output "storage_file_share_name" {
  value = azurerm_storage_share.storage-fs.name
}

