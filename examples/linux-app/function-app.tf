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
##  examples/linux-app/function-app.tf
##
##  Linux function app on the Consumption plan (Y1) with a system-assigned managed identity, app settings and CORS.
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


## Service Plan (Linux Consumption)
resource "azurerm_service_plan" "linux" {
  location            = azurerm_resource_group.this.location
  name                = "${module.context.id}-linux-plan"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "Y1"
  tags                = module.context.tags
}


## Function App
module "function_app" {
  source  = "../../"
  context = module.context.self

  # The module adds no attributes of its own: the caller passes them and label_order decides where
  # they go. The app key (api) is the name label, so the app is named fa-<namespace>-<project>-api,
  # for example fa-rg-function-app-api. The _outputs.tf file asserts that name.
  attributes  = ["fa"]
  label_order = ["attributes", "namespace", "project", "name"]

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  linux_function_apps = {
    api = {
      https_only                 = true
      service_plan_id            = azurerm_service_plan.linux.id
      storage_account_access_key = azurerm_storage_account.this.primary_access_key
      storage_account_name       = azurerm_storage_account.this.name

      app_settings = {
        FUNCTIONS_WORKER_RUNTIME = "python"
        LOG_LEVEL                = "info"
      }

      identity = {
        type = "SystemAssigned"
      }

      site_config = {
        application_stack = {
          python_version = "3.11"
        }

        cors = {
          allowed_origins = ["https://portal.azure.com"]
        }
      }
    }
  }

  windows_function_apps                     = {}
  flex_consumption_function_apps            = {}
  linux_function_app_slots                  = {}
  windows_function_app_slots                = {}
  function_app_active_slots                 = {}
  function_app_connections                  = {}
  function_app_functions                    = {}
  function_app_hybrid_connections           = {}
  static_web_app_function_app_registrations = {}
}
