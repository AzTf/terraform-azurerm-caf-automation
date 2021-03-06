module "rg_test" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"
  
    prefix          = local.prefix
    resource_groups = local.resource_groups
    tags            = local.tags
}

module "la_test" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "1.0.0"
  
    convention          = local.convention
    location            = local.location
    name                = local.name
    solution_plan_map   = local.solution_plan_map 
    prefix              = local.prefix
    resource_group_name = module.rg_test.names.test
    tags                = local.tags
}

module "diags_asr_test" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "1.0.0"

  convention            = local.convention
  name                  = local.name
  resource_group_name   = module.rg_test.names.test
  prefix                = local.prefix
  location              = local.location
  tags                  = local.tags
  enable_event_hub      = local.enable_event_hub
}

module "automation_test" {
  source = "../../"
  
  convention               = local.convention
  name                     = local.automation_name
  rg                       = module.rg_test.names.test
  location                 = local.location 
  tags                     = local.tags
  la_workspace_id          = module.la_test.id
  diagnostics_map          = module.diags_asr_test.diagnostics_map
  diagnostics_settings     = local.diagnostics_settings
}
