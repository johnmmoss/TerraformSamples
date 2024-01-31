
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                        = replace("${var.application_short}kv${var.environment}${var.location_short_name}", "-", "")
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  sku_name                    = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     key_permissions = [
#       "get",
#       "list",
#       "create",
#       "delete",
#     ]

#     secret_permissions = [
#       "get",
#       "list",
#       "set",
#       "delete",
#       "purge",
#       "recover"
#     ]
#   }

  lifecycle {
    ignore_changes = [access_policy]
  }

  tags = {
    displayName : "${var.application}-vault-${var.environment}-${var.location_short_name}"
    product : var.application
  }
}