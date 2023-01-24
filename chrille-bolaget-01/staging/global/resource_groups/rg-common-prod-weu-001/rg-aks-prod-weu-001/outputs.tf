# chrille-bolaget-01/staging/global/resource_gorups/outputs.tf

output "resource_group_name" {
  value = var.resource_group_name
  depends_on = [azurerm_resource_group.resource_group]
}