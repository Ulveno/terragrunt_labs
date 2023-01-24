# chrille-bolaget-01/staging/global/resource_groups/terragrunt.hcl

include {
    path = find_in_parent_folders()
}

inputs = {
    resource_group_name = "rg-common-prod-weu-001"
}