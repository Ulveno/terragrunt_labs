resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = var.nsg_rules
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

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
    subnet_id                 = var.subnet_id
    network_security_group_id = azurerm_network_security_group.nsg.id
}