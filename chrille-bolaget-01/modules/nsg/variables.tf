##### ---------- > NSG vairables
variable "nsg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "subnet_id" {
  type = string
}

variable "nsg_rules" {
type = list(object({
       rule_name                    = string
       priority                     = number
       direction                    = string
       access                       = string
       protocol                     = string
       source_port_ranges           = list(string)
       destination_port_ranges      = list(string)
       source_address_prefixes      = list(string)
       destination_address_prefixes = list(string)
}))
}





