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



