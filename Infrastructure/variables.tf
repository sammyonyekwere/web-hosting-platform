variable "location" {
  type    = string
  default = "UK South"
}

variable "sitename" {
  type    = string
  default = "webapp"
}

variable "resource_group_name" {
  type    = string
  default = "rg-web-prod"
}

variable "environment" {
  type    = string
  default = "staging"
}