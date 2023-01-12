# chrille-bolaget-01/staging/global/resource_groups/resource_groups.tf

resource "azurerm_resource_group" "vnet_resource_group" {
  name     = var.vnet_resource_group_name
  location = var.location
}