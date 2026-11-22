output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}

output "storage_file_share_id" {
  value = azurerm_storage_share.storage-fs.id
}