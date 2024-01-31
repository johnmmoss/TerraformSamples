resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-${var.environment}-${var.location_short_name}"
  location = var.location
  tags     = { application : "configdemo", description : "Test moving of config resource" }
}
