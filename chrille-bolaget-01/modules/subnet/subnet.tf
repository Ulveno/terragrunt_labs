resource "azurerm_subnet" "subnet" {
    count               = length(var.subnets)
    name                = var.subnets[count.index].name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes     = var.subnets[count.index].address_prefixes
 
    dynamic "delegation" {
      for_each = length(var.subnets[count.index].delegation) < 1 ? var.subnets[count.index].delegation : []
    content {
        name = "delegation"
        service_delegation {
            name    = delegation.value.name
            actions = delgeation.value.actions
      }
     }
    }
}