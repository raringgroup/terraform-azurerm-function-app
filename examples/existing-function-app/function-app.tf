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
##  examples/existing-function-app/function-app.tf
##
##  Adds a slot and a function to a function app that already exists, referring to it by ID (function_app_id) instead of by key. The "existing" app is created inline here only so the example is self-contained.
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


## Service Plan (Linux Elastic Premium, supports slots)
resource "azurerm_service_plan" "linux" {
  location            = azurerm_resource_group.this.location
  name                = "${module.context.id}-linux-plan"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "EP1"
  tags                = module.context.tags
}


## The app that already exists (in a real setup this is not part of the same configuration)
resource "azurerm_linux_function_app" "existing" {
  location                   = azurerm_resource_group.this.location
  name                       = "${module.context.id}-existing"
  resource_group_name        = azurerm_resource_group.this.name
  service_plan_id            = azurerm_service_plan.linux.id
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  storage_account_name       = azurerm_storage_account.this.name
  tags                       = module.context.tags

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }
}


## Slot and function added to the existing app by ID
module "function_app" {
  source  = "../../"
  context = module.context.self

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  linux_function_app_slots = {
    staging = {
      function_app_id            = azurerm_linux_function_app.existing.id
      storage_account_access_key = azurerm_storage_account.this.primary_access_key
      storage_account_name       = azurerm_storage_account.this.name

      site_config = {
        application_stack = {
          python_version = "3.11"
        }
      }
    }
  }

  function_app_functions = {
    hello = {
      function_app_id = azurerm_linux_function_app.existing.id
      language        = "Python"

      config_json = jsonencode({
        bindings = [
          {
            authLevel = "function"
            direction = "in"
            methods   = ["get"]
            name      = "req"
            type      = "httpTrigger"
          },
          {
            direction = "out"
            name      = "$return"
            type      = "http"
          }
        ]
      })
    }
  }

  linux_function_apps                       = {}
  windows_function_apps                     = {}
  flex_consumption_function_apps            = {}
  windows_function_app_slots                = {}
  function_app_active_slots                 = {}
  function_app_connections                  = {}
  function_app_hybrid_connections           = {}
  static_web_app_function_app_registrations = {}
}
