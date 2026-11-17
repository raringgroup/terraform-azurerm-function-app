mock_provider "azurerm" {
  mock_resource "azurerm_linux_function_app" {
    defaults = { id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/sites/linux-app" }
  }
  mock_resource "azurerm_windows_function_app" {
    defaults = { id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/sites/windows-app" }
  }
  mock_resource "azurerm_function_app_flex_consumption" {
    defaults = { id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/sites/flex-app" }
  }
  mock_resource "azurerm_linux_function_app_slot" {
    defaults = { id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/sites/linux-app/slots/staging" }
  }
}

variables {
  namespace   = "upsis"
  environment = "dev"
  name        = "ignored"

  resource_group_name = "rg-test"
  location            = "eastus"

  linux_function_apps                       = {}
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

run "names_and_cross_references" {
  command = apply

  variables {
    linux_function_apps = {
      api = {
        service_plan_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/serverFarms/plan"
        site_config                = {}
        storage_account_name       = "stfuncapp"
        storage_account_access_key = "not-a-real-key"
      }
    }
    windows_function_apps = {
      winapi = {
        service_plan_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/serverFarms/plan"
        site_config                = {}
        storage_account_name       = "stfuncapp"
        storage_account_access_key = "not-a-real-key"
      }
    }
    flex_consumption_function_apps = {
      flexapi = {
        service_plan_id             = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/serverFarms/plan"
        site_config                 = {}
        runtime_name                = "python"
        runtime_version             = "3.11"
        storage_authentication_type = "StorageAccountConnectionString"
        storage_container_endpoint  = "https://sa.blob.core.windows.net/deploy"
        storage_container_type      = "blobContainer"
        storage_access_key          = "not-a-real-key"
      }
    }
    linux_function_app_slots = {
      staging = {
        function_app_key           = "api"
        site_config                = {}
        storage_account_name       = "stfuncapp"
        storage_account_access_key = "not-a-real-key"
      }
    }
    function_app_active_slots = {
      swap = { slot_key = "staging" }
    }
    function_app_functions = {
      hello = {
        function_app_key = "flexapi"
        config_json      = "{}"
      }
    }
    function_app_hybrid_connections = {
      relay = {
        function_app_key = "winapi"
        hostname         = "host.example.com"
        port             = 443
        relay_id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Relay/namespaces/ns/hybridConnections/hc"
      }
    }
    static_web_app_function_app_registrations = {
      swa = {
        function_app_key  = "api"
        static_web_app_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/staticSites/swa"
      }
    }
  }

  assert {
    condition     = azurerm_linux_function_app.this["api"].name == "upsis-dev-api-func" && azurerm_windows_function_app.this["winapi"].name == "upsis-dev-winapi-func" && azurerm_function_app_flex_consumption.this["flexapi"].name == "upsis-dev-flexapi-func"
    error_message = "each app kind must be named from the context and its map key"
  }
  assert {
    condition     = azurerm_linux_function_app_slot.this["staging"].function_app_id == azurerm_linux_function_app.this["api"].id && azurerm_linux_function_app_slot.this["staging"].name == "staging"
    error_message = "a slot must resolve function_app_key to the app created by this module"
  }
  assert {
    condition     = azurerm_function_app_active_slot.this["swap"].slot_id == azurerm_linux_function_app_slot.this["staging"].id
    error_message = "an active slot must resolve slot_key to the slot created by this module"
  }
  assert {
    condition     = azurerm_function_app_function.this["hello"].function_app_id == azurerm_function_app_flex_consumption.this["flexapi"].id
    error_message = "a function must resolve function_app_key against any app kind (here a flex app)"
  }
  assert {
    condition     = azurerm_function_app_hybrid_connection.this["relay"].function_app_id == azurerm_windows_function_app.this["winapi"].id
    error_message = "a hybrid connection must resolve function_app_key against any app kind (here a windows app)"
  }
  assert {
    condition     = azurerm_static_web_app_function_app_registration.this["swa"].function_app_id == azurerm_linux_function_app.this["api"].id
    error_message = "a registration must resolve function_app_key against any app kind (here a linux app)"
  }
}

run "an_existing_id_can_be_used_instead_of_a_key" {
  command = plan

  variables {
    function_app_hybrid_connections = {
      relay = {
        function_app_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/sites/existing"
        hostname        = "host.example.com"
        port            = 443
        relay_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Relay/namespaces/ns/hybridConnections/hc"
      }
    }
  }

  assert {
    condition     = azurerm_function_app_hybrid_connection.this["relay"].function_app_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/sites/existing"
    error_message = "function_app_id must pass through when no key is given"
  }
}

run "setting_neither_a_key_nor_an_id_is_rejected" {
  command = plan

  variables {
    function_app_hybrid_connections = {
      relay = {
        hostname = "host.example.com"
        port     = 443
        relay_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Relay/namespaces/ns/hybridConnections/hc"
      }
    }
  }

  expect_failures = [azurerm_function_app_hybrid_connection.this]
}

run "setting_both_a_key_and_an_id_is_rejected" {
  command = plan

  variables {
    linux_function_app_slots = {
      staging = {
        function_app_key           = "api"
        function_app_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/sites/existing"
        site_config                = {}
        storage_account_name       = "stfuncapp"
        storage_account_access_key = "not-a-real-key"
      }
    }
  }

  expect_failures = [azurerm_linux_function_app_slot.this]
}

run "empty_maps_create_nothing" {
  command = plan

  assert {
    condition     = length(azurerm_linux_function_app.this) + length(azurerm_windows_function_app.this) + length(azurerm_function_app_flex_consumption.this) == 0
    error_message = "empty maps must create nothing"
  }
}

run "disabled_module_creates_nothing" {
  command = plan

  variables {
    enabled = false
    linux_function_apps = {
      api = {
        service_plan_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/serverFarms/plan"
        site_config                = {}
        storage_account_name       = "stfuncapp"
        storage_account_access_key = "not-a-real-key"
      }
    }
  }

  assert {
    condition     = length(azurerm_linux_function_app.this) == 0
    error_message = "a disabled module must create nothing even when apps are given"
  }
}
