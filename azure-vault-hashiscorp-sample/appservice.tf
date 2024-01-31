resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "covid19-booking-appservice-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "jomowebapp" {
  name                = "jomowebapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  site_config {
    dotnet_framework_version  = "v6.0"
    use_32_bit_worker_process = true
    scm_type                  = "LocalGit"
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "AppSecrets__ApimApiUrl" = "@Microsoft.KeyVault(SecretUri=${data.azurerm_key_vault_secret.apim-secret.id})"
  }
}
