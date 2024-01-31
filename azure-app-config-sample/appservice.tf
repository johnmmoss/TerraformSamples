# ======================================================================================
# WebApp App Service Plan
# ======================================================================================

resource "azurerm_app_service_plan" "app_service_plan_webapp" {
  name                = "${var.application}-plan-${var.environment}-${var.location_short_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "app"
  reserved            = false

  sku {
    tier     = "Standard"     #var.app_service_plan_tier
    size     = "S1"           #var.app_service_plan_size
    capacity = "1"             #var.app_service_plan_capacity
  }
}

# ======================================================================================
# WebApp
# ======================================================================================

resource "azurerm_app_service" "webapp" {
  name                    = "${var.application}-${var.environment}-${var.location_short_name}"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  https_only              = true
  enabled                 = true
  client_affinity_enabled = false
  app_service_plan_id     = azurerm_app_service_plan.app_service_plan_webapp.id

#   site_config {
#     always_on        = true
#     app_command_line = var.app_service_application_dll
#     scm_type         = "VSTSRM"
#   }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT"                     = "Development"
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      tags # Ignore changes to tags, avoiding loss of Azure link to App Insights 
    ]
  }
}