##### ---------------- > AKS variables
variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "default_node_pool" {
  type = string
}
variable "default_node_pool_name_count" {
  type = number
}
variable "default_node_pool_name_vm_size" {
  type = string
}


 