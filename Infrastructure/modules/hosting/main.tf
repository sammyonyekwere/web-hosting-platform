locals {
  uploads_directory = "/mounts/uploads"
}



resource "azurerm_service_plan" "app" {
  name                = "web-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app.id
  https_only          = true

  app_settings = {
    DATABASE_NAME     = var.database_name
    DATABASE_HOSTNAME = var.database_hostname
    UPLOAD_DIRECTORY  = local.uploads_directory
    SMTP_FROM_EMAIL   = var.app_email
    SMTP_FROM_NAME    = var.app_name
  }

  site_config {
    always_on = true
    application_stack {
      php_version = "8.3"
    }
  }

  storage_account {
    name         = "uploads"
    access_key   = var.storage_access_key
    account_name = var.storage_account_name
    share_name   = var.storage_share_name
    type         = "AzureFiles"
    mount_path   = local.uploads_directory
  }






  #   logs {
  #     application_logs {
  #         file_system_level = "Error"
  #       azure_blob_storage {
  #         level = "Error"
  #         retention_in_days = 7
  #         sas_url = "https://${var.storage_account_name}.blob.core.windows.net/${var.storage_container_name}${var.storage_account_sas.}&sr=b"
  #       }
  #     }
  #   }
}