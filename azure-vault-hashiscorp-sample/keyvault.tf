
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "covid19-rg-dev-jomo"
  location = "West Europe"
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "covid19bookingkvdevjomo"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  lifecycle {
    ignore_changes = [access_policy]
  }
}

resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
  ]
  secret_permissions = [
    "Get",
    "Set",
    "List",
  ]
  storage_permissions = [
    "Get",
  ]
}

resource "azurerm_key_vault_access_policy" "web_access_policy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_app_service.jomowebapp.identity[0].principal_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}

resource "azurerm_key_vault_secret" "apim-secret" {
  name         = "apim-secret"
  value        = "http://some/url/manuall/set"
  key_vault_id = azurerm_key_vault.keyvault.id
}
