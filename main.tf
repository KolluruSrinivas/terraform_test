provider "azurerm" {
  features {}
}

# Define the resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Define the App Service Plan
resource "azurerm_app_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "App"
  reserved            = false  # Set to true if using Linux

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Define the App Service
resource "azurerm_app_service" "example" {
  name                = "example-app-service"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  site_config {
    dotnet_framework_version = "v6.0"
  }
}

output "app_service_url" {
  value = azurerm_app_service.example.default_site_hostname
}
