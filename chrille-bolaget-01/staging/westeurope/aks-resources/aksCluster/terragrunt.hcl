# chrille-bolaget-01/staging/westeurope/hub-vnet/terragrunt.hcl

terraform {
    source = "../../../../modules/aks"
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

inputs = {}