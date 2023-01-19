resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    resource_group_name = var.resource_group_name
    location            = var.location
    address_space       = var.address_space
    dns_servers         = var.dns_servers
    tags                = var.tags
  
}


resource "azurerm_subnet" "subnet" {
    count               = length(var.subnets)
    name                = var.subnets[count.index].name
    resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = var.subnets[count.index].address_prefixes
    service_endpoints    = var.subnets[count.index].service_endpoints 
 
    dynamic "delegation" {
      for_each = length(var.subnets[count.index].delegations) < 1 ? var.subnets[count.index].delegations : []
    content {
        name = "delegation"
        service_delegation {
            name    = delegation.value.name
            actions = delgeation.value.actions
      }
     }
    }
}
