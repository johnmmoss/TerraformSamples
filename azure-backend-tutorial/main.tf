
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.77.0"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "tfstatestorage613307971"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-MockApiTest"
  location = "ukwest"
  tags = {
    Environment = "Terraform Getting Started"
    Team        = "DevOps"
  }
}

#data "azurerm_subscription" "current" {}

resource "azurerm_service_plan" "mockapi_plan" {
  name                = "Moss-MockApiTest-Plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "mockapi_app" {
  name                = "Moss-MockApiTest-ukwest"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.mockapi_plan.id
  https_only          = true

  site_config {
    minimum_tls_version = "1.2"
    #linux_fx_version = "DOCKER|index.docker.io/v1/mockserver/mockserver:latest"
    application_stack {
      docker_registry_url = "https://index.docker.io"
      docker_image_name   = "mockserver/mockserver:latest"
    }
  }

  app_settings = {
    # Expose port on container
    "WEBSITES_PORT" = "1080"
  }

  identity {
    type = "SystemAssigned"
  }
}
