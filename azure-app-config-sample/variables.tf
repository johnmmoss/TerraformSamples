variable "environment" {
  type = string
  default= "dev"
}

variable "location_short_name" {
  type = string
  default = "uks"
}

variable "application" {
  type    = string
  default = "configdemo"
}

variable "resource_group_name" {
      type = string
      default = "configdemo-rg"
}

variable "location" {
      type = string
      default = "uksouth"
}

variable "app_config_location" {
  description = "Specifies the app config location (allowing it to be in a different region to the resource group)"
  type        = string
  //default     = "uksouth"
  default     = "ukwest"
}

variable "app_config_sku" {
  description = "Specifies the plan's pricing tier"
  type        = string
  default     = "standard"
}