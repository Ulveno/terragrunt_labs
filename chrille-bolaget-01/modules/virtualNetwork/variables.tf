variable "vnet_name" {
  type = string
  description = "(Required)"
}

variable "resource_group_name" {
  type = string
  description = "(Required)"
}

variable "location" {
  type = string
  description = "(Required)"
}

variable "address_space" {
  type = list(string)
  description = "(Required)"
}

variable "dns_servers" {
  type = list(string)
  description = "(Optional)"
  default = []
}

variable "tags" {
  type = map(string)
  description = "(Optional)"
  default = {}
}

##### ------- > Subnet variables

variable "subnets" {
  type = list(object({
    name = string
    address_prefixes = list(string)
    service_endpoints = list(string)
    delegations = list(object({
      name = string
      actions = list(string)
    }))
  }))
  default = []
}

##### ---------- > NSG vairables

variable "nsg" {
  type = list(object({
    nsg_name = string
    tags     = map(string)
    security_rules = list(object({
      rule_name = string
      priority  = number
      direction = string
      access    = string
      protocol  = string
      source_port_ranges           = set(string)
      destination_port_ranges      = set(string)
      source_address_prefixes      = set(string)
      destination_address_prefixes = set(string)
    }))
  }))
  default = []
}

