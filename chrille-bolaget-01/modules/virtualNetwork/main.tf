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

resource "azurerm_network_security_group" "nsg" {
  count = length(var.nsg)
  name                = var.nsg[count.index].nsg_name
  location            = azurerm_virtual_network.vnet.resource_group_name
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
  tags                = var.nsg[count.index].tags
    dynamic "security_rule" {
    for_each = length(var.nsg[count.index].security_rules) < 1 ? var.nsg[count.index].security_rules : []
    content {
       name                         = security_rule.value.rule_name
       priority                     = security_rule.value.priority
       direction                    = security_rule.value.direction
       access                       = security_rule.value.access
       protocol                     = security_rule.value.protocol
       source_port_ranges           = security_rule.value.source_port_ranges
       destination_port_ranges      = security_rule.value.destination_port_ranges
       source_address_prefixes      = security_rule.value.source_address_prefixes
       destination_address_prefixes = security_rule.value.destination_address_prefixes
    }
  }
}

#resource "azurerm_network_security_group" "example" {
#  name                = "acceptanceTestSecurityGroup1"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#
#  security_rule {
#    name                       = "test123"
#    priority                   = 100
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Tcp"
#    source_port_range          = "*"
#    destination_port_range     = "*"
#    source_address_prefix      = "*"
#    destination_address_prefix = "*"
#  }
#
#  tags = {
#    environment = "Production"
#  }
#}
##
#resource "azurerm_subnet_network_security_group_association" "nsg_association" {
#  dynamic "nsg_association" {
#    content = {
#    name = "nsg_a"
#
#
#    }
#  }
#  subnet_id                 = azurerm_subnet.example.id
#  network_security_group_id = azurerm_network_security_group.example.id
#}