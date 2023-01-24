# chrille-bolaget-01/staging/westeurope/hub-vnet/terragrunt.hcl

terraform {
    source = "../../../../modules/nsg"
}

include {
    path = find_in_parent_folders()
}

dependencies {
 paths = ["../../../global/resource_groups"]
}

dependency "resource_groups" {
config_path = "../../../global/resource_groups"
mock_outputs  = {
    vnet_resource_group_name = "rg-terragrunt-mock-001"
}
mock_outputs_merge_with_state = true
}

locals {
    env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
    environment = local.env_vars.locals.environment
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    location    = local.region_vars.locals.location
}

inputs = {
    nsg_name = "test"
    tags     = {
        "test" = local.environment
    }
    location = local.location
    resource_group_name = dependency.resource_groups.outputs.vnet_resource_group_name
    subnet_id = "/subscriptions/dd7b30f8-c637-48ab-a9c3-ed3dc4f285a9/resourceGroups/rg-example-vnet/providers/Microsoft.Network/virtualNetworks/vnet-hub-staging-westeurope-002/subnets/test-snet"
    nsg_rules = [
    {
      rule_name = "test2"
      priority  = 300
      direction = "Outbound"
      access    = "Allow"
      protocol  = "*"
      source_port_ranges           = ["443"]
      destination_port_ranges      = ["445"]
      source_address_prefixes      = ["10.10.0.0/16"]
      destination_address_prefixes = ["10.15.0.0/16"]
    }
]
}