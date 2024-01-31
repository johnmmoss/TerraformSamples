resource "azurerm_app_configuration" "appconf" {
  name                = "${var.application}-config-${var.environment}-${var.location_short_name}"
  resource_group_name = azurerm_resource_group.rg.name
  # location            = azurerm_resource_group.rg.location
  # Currently the app config within the UKW resource group has been created in the UKS region
  # To move it is a destructive action, hence why app_config_location allows us to seperate out this
  # resource's location to that of the resource group - see ticket C19V-1600 for details
  location = var.app_config_location
  sku      = var.app_config_sku
  #tags     = var.tags
}

# This output is used by the terraform process used in our web app deployments
# to allow the management of app setting keys
# consuming template is: 
# https://dev.azure.com/nhsuk/covid19.vaccine-booking/_git/covid19.vaccine-booking?path=/src/Covid19.VaccineBooking.Web/Covid19.VaccineBooking.Web/AppConfiguration/terraform/common/appconfigsettings.tf&version=GBmaster&_a=contents
output "appconf_id" {
  value = azurerm_app_configuration.appconf.id
}
