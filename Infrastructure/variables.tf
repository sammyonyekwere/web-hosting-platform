variable "location" {
  type    = string
  default = "UK South"
}

variable "app_name" {
  type = string
}

variable "app_email" {
  type = string
}

variable "resource_group_name" {
  type    = string
  default = "rg-web-prod"
}

variable "environment" {
  type    = string
  default = "staging"
}

variable "administrator_login" {
  type = string
}

variable "administrator_password" {
  type      = string
  sensitive = true
}

variable "github_service_principal_object_id" {
  type      = string
}