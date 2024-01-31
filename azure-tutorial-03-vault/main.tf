locals {
  org_name_short  = "covid19-booking"
  app_name_short  = "vaulttest"
  resource_prefix = "${local.org_name_short}-${local.app_name_short}"
}

# terraform {
#   required_version = ">= 1.0.0, < 2.0.0"
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.0.2"
#     }
#   }
# }

# provider "azurerm" {
#   features {}
# }

resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_prefix}-rg-ukw"
  location = "ukwest"
}

resource "azurerm_app_service_plan" "webapp-plan" {
  name                = "${local.resource_prefix}-webapp-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  #   os_type             = "Linux"
  #sku_name            = "F1"
  sku {
    tier = "Standard"
    size = "S1"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "${local.resource_prefix}-webapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  #   service_plan_id     = azurerm_service_plan.webapp-plan.id
  app_service_plan_id = azurerm_app_service_plan.webapp-plan.id

  site_config {
    # Free tier must have always_on set to false else deploy fails
    always_on = false
  }
}
