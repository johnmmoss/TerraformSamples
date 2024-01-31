data "azurerm_key_vault_secret" "apim-secret" {
  name         = "apim-secret"
  key_vault_id = azurerm_key_vault.keyvault.id
}
