# chrille-bolaget-01/staging/global/resource_groups/resource_groups.tf

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}