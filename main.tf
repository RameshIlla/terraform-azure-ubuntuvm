provider "azurerm"
{
    version = "2.90.0"
}

#Create a resource group
resource "azurerm_resource_group" "vm resource group"
{
    name = "vm-resource-group"
    location = var.location
}