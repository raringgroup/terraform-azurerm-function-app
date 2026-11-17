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
##  function-app-extras.tf
##
##  Active slot swaps, service connections, functions, hybrid connections and Static Web App registrations.
## ----------------------------------------------------------------------------

## Function App Active Slots
resource "azurerm_function_app_active_slot" "this" {
  for_each = module.context.enabled ? var.function_app_active_slots : {}

  overwrite_network_config = each.value.overwrite_network_config
  slot_id                  = try(azurerm_linux_function_app_slot.this[each.value.slot_key].id, azurerm_windows_function_app_slot.this[each.value.slot_key].id, each.value.slot_id)

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  lifecycle {
    precondition {
      condition     = (each.value.slot_key == null) != (each.value.slot_id == null)
      error_message = "In function_app_active_slots: exactly one of slot_key and slot_id must be set."
    }
  }
}


## Function App Service Connections
resource "azurerm_function_app_connection" "this" {
  for_each = module.context.enabled ? var.function_app_connections : {}

  name               = each.key
  client_type        = each.value.client_type
  function_app_id    = try(azurerm_linux_function_app.this[each.value.function_app_key].id, azurerm_windows_function_app.this[each.value.function_app_key].id, azurerm_function_app_flex_consumption.this[each.value.function_app_key].id, each.value.function_app_id)
  target_resource_id = each.value.target_resource_id
  vnet_solution      = each.value.vnet_solution

  dynamic "authentication" {
    for_each = each.value.authentication == null ? [] : [each.value.authentication]
    content {
      certificate     = authentication.value.certificate
      client_id       = authentication.value.client_id
      name            = authentication.value.name
      principal_id    = authentication.value.principal_id
      secret          = authentication.value.secret
      subscription_id = authentication.value.subscription_id
      type            = authentication.value.type
    }
  }

  dynamic "secret_store" {
    for_each = each.value.secret_store == null ? [] : [each.value.secret_store]
    content {
      key_vault_id = secret_store.value.key_vault_id
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  lifecycle {
    precondition {
      condition     = (each.value.function_app_key == null) != (each.value.function_app_id == null)
      error_message = "In function_app_connections: exactly one of function_app_key and function_app_id must be set."
    }
  }
}


## Functions inside a Function App
resource "azurerm_function_app_function" "this" {
  for_each = module.context.enabled ? var.function_app_functions : {}

  name            = each.key
  config_json     = each.value.config_json
  enabled         = each.value.enabled
  function_app_id = try(azurerm_linux_function_app.this[each.value.function_app_key].id, azurerm_windows_function_app.this[each.value.function_app_key].id, azurerm_function_app_flex_consumption.this[each.value.function_app_key].id, each.value.function_app_id)
  language        = each.value.language
  test_data       = each.value.test_data

  dynamic "file" {
    for_each = each.value.file == null ? [] : each.value.file
    content {
      content = file.value.content
      name    = file.value.name
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  lifecycle {
    precondition {
      condition     = (each.value.function_app_key == null) != (each.value.function_app_id == null)
      error_message = "In function_app_functions: exactly one of function_app_key and function_app_id must be set."
    }
  }
}


## Function App Hybrid Connections
resource "azurerm_function_app_hybrid_connection" "this" {
  for_each = module.context.enabled ? var.function_app_hybrid_connections : {}

  function_app_id = try(azurerm_linux_function_app.this[each.value.function_app_key].id, azurerm_windows_function_app.this[each.value.function_app_key].id, azurerm_function_app_flex_consumption.this[each.value.function_app_key].id, each.value.function_app_id)
  hostname        = each.value.hostname
  port            = each.value.port
  relay_id        = each.value.relay_id
  send_key_name   = each.value.send_key_name

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  lifecycle {
    precondition {
      condition     = (each.value.function_app_key == null) != (each.value.function_app_id == null)
      error_message = "In function_app_hybrid_connections: exactly one of function_app_key and function_app_id must be set."
    }
  }
}


## Static Web App Function App Registrations
resource "azurerm_static_web_app_function_app_registration" "this" {
  for_each = module.context.enabled ? var.static_web_app_function_app_registrations : {}

  function_app_id   = try(azurerm_linux_function_app.this[each.value.function_app_key].id, azurerm_windows_function_app.this[each.value.function_app_key].id, azurerm_function_app_flex_consumption.this[each.value.function_app_key].id, each.value.function_app_id)
  static_web_app_id = each.value.static_web_app_id

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
    }
  }

  lifecycle {
    precondition {
      condition     = (each.value.function_app_key == null) != (each.value.function_app_id == null)
      error_message = "In static_web_app_function_app_registrations: exactly one of function_app_key and function_app_id must be set."
    }
  }
}
