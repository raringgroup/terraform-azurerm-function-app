## ----------------------------------------------------------------------------
## Copyright 2026 Raring Group LLC
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
## ----------------------------------------------------------------------------
##
##  examples/windows-slots/function-app.tf
##
##  Windows function app on Elastic Premium (EP1) with a staging slot and an active-slot swap. Slots need a plan that supports them, so Consumption (Y1) cannot be used.
## ----------------------------------------------------------------------------

## Resource Group
resource "azurerm_resource_group" "this" {
  location = var.region
  name     = "${module.context.id}-rg"
  tags     = module.context.tags
}


## Storage Account used by the apps
resource "azurerm_storage_account" "this" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.this.location
  name                     = substr(replace("${module.context.id}st", "-", ""), 0, 24)
  resource_group_name      = azurerm_resource_group.this.name
  tags                     = module.context.tags
}


## Service Plan (Windows Elastic Premium, supports slots)
resource "azurerm_service_plan" "windows" {
  location            = azurerm_resource_group.this.location
  name                = "${module.context.id}-windows-plan"
  os_type             = "Windows"
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "EP1"
  tags                = module.context.tags
}


## Function App with a slot, then swapped into production
module "function_app" {
  source  = "../../"
  context = module.context.self

  # The module adds no attributes of its own. This example passes "func" to keep the names the
  # previous version generated (<context>-<app key>-func).
  attributes = ["func"]

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  windows_function_apps = {
    jobs = {
      https_only                 = true
      service_plan_id            = azurerm_service_plan.windows.id
      storage_account_access_key = azurerm_storage_account.this.primary_access_key
      storage_account_name       = azurerm_storage_account.this.name

      site_config = {
        application_stack = {
          dotnet_version = "v8.0"
        }
      }
    }
  }

  windows_function_app_slots = {
    staging = {
      function_app_key           = "jobs"
      https_only                 = true
      storage_account_access_key = azurerm_storage_account.this.primary_access_key
      storage_account_name       = azurerm_storage_account.this.name

      site_config = {
        application_stack = {
          dotnet_version = "v8.0"
        }
      }
    }
  }

  function_app_active_slots = {
    swap = {
      slot_key = "staging"
    }
  }

  linux_function_apps                       = {}
  flex_consumption_function_apps            = {}
  linux_function_app_slots                  = {}
  function_app_connections                  = {}
  function_app_functions                    = {}
  function_app_hybrid_connections           = {}
  static_web_app_function_app_registrations = {}
}
