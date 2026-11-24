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
##  examples/flex-consumption/function-app.tf
##
##  Flex Consumption function app (FC1) with always-ready instances, a deployment container and a managed identity.
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

resource "azurerm_storage_container" "deployments" {
  name                  = "deployments"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}


## Service Plan (Flex Consumption)
resource "azurerm_service_plan" "flex" {
  location            = azurerm_resource_group.this.location
  name                = "${module.context.id}-flex-plan"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "FC1"
  tags                = module.context.tags
}


## Function App
module "function_app" {
  source  = "../../"
  context = module.context.self

  # The module adds no attributes of its own. This example passes "func" to keep the names the
  # previous version generated (<context>-<app key>-func).
  attributes = ["func"]

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  flex_consumption_function_apps = {
    events = {
      https_only                  = true
      instance_memory_in_mb       = 2048
      maximum_instance_count      = 40
      runtime_name                = "python"
      runtime_version             = "3.11"
      service_plan_id             = azurerm_service_plan.flex.id
      storage_access_key          = azurerm_storage_account.this.primary_access_key
      storage_authentication_type = "StorageAccountConnectionString"
      storage_container_endpoint  = "${azurerm_storage_account.this.primary_blob_endpoint}${azurerm_storage_container.deployments.name}"
      storage_container_type      = "blobContainer"

      always_ready = [
        {
          instance_count = 1
          name           = "http"
        }
      ]

      identity = {
        type = "SystemAssigned"
      }

      site_config = {}
    }
  }

  linux_function_apps                       = {}
  windows_function_apps                     = {}
  linux_function_app_slots                  = {}
  windows_function_app_slots                = {}
  function_app_active_slots                 = {}
  function_app_connections                  = {}
  function_app_functions                    = {}
  function_app_hybrid_connections           = {}
  static_web_app_function_app_registrations = {}
}
