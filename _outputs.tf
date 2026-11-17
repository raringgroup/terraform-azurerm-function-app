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
##  _outputs.tf
##
##  Output values. Site credentials and keys are never output.
## ----------------------------------------------------------------------------

output "linux_function_apps" {
  description = "Attributes of the azurerm_linux_function_app created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_linux_function_app.this : k => {
      id                                = v.id
      default_hostname                  = v.default_hostname
      hosting_environment_id            = v.hosting_environment_id
      kind                              = v.kind
      outbound_ip_address_list          = v.outbound_ip_address_list
      outbound_ip_addresses             = v.outbound_ip_addresses
      possible_outbound_ip_address_list = v.possible_outbound_ip_address_list
      possible_outbound_ip_addresses    = v.possible_outbound_ip_addresses
      identity                          = try(v.identity, null)
    }
  }
}

output "windows_function_apps" {
  description = "Attributes of the azurerm_windows_function_app created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_windows_function_app.this : k => {
      id                                = v.id
      default_hostname                  = v.default_hostname
      hosting_environment_id            = v.hosting_environment_id
      kind                              = v.kind
      outbound_ip_address_list          = v.outbound_ip_address_list
      outbound_ip_addresses             = v.outbound_ip_addresses
      possible_outbound_ip_address_list = v.possible_outbound_ip_address_list
      possible_outbound_ip_addresses    = v.possible_outbound_ip_addresses
      identity                          = try(v.identity, null)
    }
  }
}

output "flex_consumption_function_apps" {
  description = "Attributes of the azurerm_function_app_flex_consumption created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_function_app_flex_consumption.this : k => {
      id                                = v.id
      default_hostname                  = v.default_hostname
      hosting_environment_id            = v.hosting_environment_id
      kind                              = v.kind
      outbound_ip_address_list          = v.outbound_ip_address_list
      outbound_ip_addresses             = v.outbound_ip_addresses
      possible_outbound_ip_address_list = v.possible_outbound_ip_address_list
      possible_outbound_ip_addresses    = v.possible_outbound_ip_addresses
      identity                          = try(v.identity, null)
    }
  }
}

output "linux_function_app_slots" {
  description = "Attributes of the azurerm_linux_function_app_slot created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_linux_function_app_slot.this : k => {
      id                                = v.id
      default_hostname                  = v.default_hostname
      hosting_environment_id            = v.hosting_environment_id
      kind                              = v.kind
      outbound_ip_address_list          = v.outbound_ip_address_list
      outbound_ip_addresses             = v.outbound_ip_addresses
      possible_outbound_ip_address_list = v.possible_outbound_ip_address_list
      possible_outbound_ip_addresses    = v.possible_outbound_ip_addresses
      identity                          = try(v.identity, null)
    }
  }
}

output "windows_function_app_slots" {
  description = "Attributes of the azurerm_windows_function_app_slot created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_windows_function_app_slot.this : k => {
      id                                = v.id
      default_hostname                  = v.default_hostname
      hosting_environment_id            = v.hosting_environment_id
      kind                              = v.kind
      outbound_ip_address_list          = v.outbound_ip_address_list
      outbound_ip_addresses             = v.outbound_ip_addresses
      possible_outbound_ip_address_list = v.possible_outbound_ip_address_list
      possible_outbound_ip_addresses    = v.possible_outbound_ip_addresses
      identity                          = try(v.identity, null)
    }
  }
}

output "function_app_active_slots" {
  description = "Attributes of the azurerm_function_app_active_slot created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_function_app_active_slot.this : k => {
      id                   = v.id
      last_successful_swap = v.last_successful_swap
    }
  }
}

output "function_app_connections" {
  description = "Attributes of the azurerm_function_app_connection created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_function_app_connection.this : k => {
      id = v.id
    }
  }
}

output "function_app_functions" {
  description = "Attributes of the azurerm_function_app_function created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_function_app_function.this : k => {
      id                   = v.id
      config_url           = v.config_url
      invocation_url       = v.invocation_url
      script_root_path_url = v.script_root_path_url
      script_url           = v.script_url
      secrets_file_url     = v.secrets_file_url
      test_data_url        = v.test_data_url
      url                  = v.url
    }
  }
}

output "function_app_hybrid_connections" {
  description = "Attributes of the azurerm_function_app_hybrid_connection created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_function_app_hybrid_connection.this : k => {
      id                    = v.id
      namespace_name        = v.namespace_name
      relay_name            = v.relay_name
      service_bus_namespace = v.service_bus_namespace
      service_bus_suffix    = v.service_bus_suffix
    }
  }
}

output "static_web_app_function_app_registrations" {
  description = "Attributes of the azurerm_static_web_app_function_app_registration created by this module, keyed like the input map (empty when the module is disabled or the map is empty)"
  value = {
    for k, v in azurerm_static_web_app_function_app_registration.this : k => {
      id = v.id
    }
  }
}
