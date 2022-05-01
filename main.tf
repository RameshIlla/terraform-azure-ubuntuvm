provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = "${var.prefix}-resourcegroup"
  location = var.location
}