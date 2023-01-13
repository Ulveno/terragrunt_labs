# chrille-bolaget-01/staging/global/resource_groups/variables.tf

variable "location" {
  type = string
  description = "The Azure region to use"
}

variable "vnet_resource_group_name" {
  type = string
  description = "The name of th vnet resource group"
}
