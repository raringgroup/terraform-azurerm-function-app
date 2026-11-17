# function-app

Creates Azure Function Apps and everything that attaches to them, covering every non-deprecated function-app resource in the AzureRM provider: Linux, Windows and Flex Consumption apps, deployment slots, active-slot swaps, service connections, functions, hybrid connections and Static Web App registrations. Apps are named and tagged through the `null-context` module. Nothing in the module is specific to one hosting plan: pick the resource that matches the plan you use.

## Requirements

| Name | Version |
|------|---------|
| terraform | `>= 1.3.0` |
| azurerm | `>= 4.0.0, < 5.0.0` |

## Module Priority

No SevenPico, SevenPicoForks or CloudPosse module exists for Azure Function Apps, so the module uses the `azurerm` function-app resources directly. `_context.tf` declares the root context; it and the child contexts use `git::https://github.com/raringgroup/terraform-null-context.git?ref=v0.1.0`.

## Resources

Each resource type has its own input map. The key of a map entry names the instance. Pass `{}` for any map you do not need.

| Input | Resource | Reference |
|-------|----------|-----------|
| `linux_function_apps` | `azurerm_linux_function_app` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) |
| `windows_function_apps` | `azurerm_windows_function_app` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) |
| `flex_consumption_function_apps` | `azurerm_function_app_flex_consumption` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_flex_consumption) |
| `linux_function_app_slots` | `azurerm_linux_function_app_slot` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app_slot) |
| `windows_function_app_slots` | `azurerm_windows_function_app_slot` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app_slot) |
| `function_app_active_slots` | `azurerm_function_app_active_slot` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_active_slot) |
| `function_app_connections` | `azurerm_function_app_connection` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_connection) |
| `function_app_functions` | `azurerm_function_app_function` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_function) |
| `function_app_hybrid_connections` | `azurerm_function_app_hybrid_connection` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_hybrid_connection) |
| `static_web_app_function_app_registrations` | `azurerm_static_web_app_function_app_registration` | [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app_function_app_registration) |

`azurerm_function_app` and `azurerm_function_app_slot` are deprecated in the provider (removed in 5.0) and are not included; use the Linux or Windows resources instead.

## What the module does not create

The module takes these as inputs and does not create them:

- The **service plan** (`azurerm_service_plan`): Linux and Windows apps take any plan SKU; Flex Consumption apps need `os_type = "Linux"` and `sku_name = "FC1"`. Pass its ID as `service_plan_id`. See the `app-service` module for a plan with a web app.
- The **storage account** each app uses. Pass `storage_account_name` and `storage_account_access_key` (or use a managed identity). Flex Consumption apps also need a blob container for the deployment package, passed as `storage_container_endpoint`; the `storage-account` module declares no containers, so create the container separately.
- **Application Insights**: pass the connection string in `site_config`, or see the `application-insights` module.

## Naming

An app is named by `null-context` from the context inputs, the map key as the `name` label, and the type token `func`. For `namespace = "upsis"`, `environment = "dev"` and the key `api`, the name is `upsis-dev-api-func`. The `name` input of the context is ignored for apps, because the key takes its place. Function app names are 2 to 60 characters: letters, digits and hyphens, and can't start or end with a hyphen. The name is also the default hostname (`<name>.azurewebsites.net`), so it must be globally unique. A key must not appear in more than one app map.

Slots, functions and connections use the map key as their own name. Slot names are 2 to 59 characters: letters, digits and hyphens.

## Referring to an app, slot or other resource

Slots, connections, functions, hybrid connections and registrations point at an app. Each takes either `function_app_key` (the key of an app created by this module, in any of the three app maps; slots only look in the matching Linux or Windows map) or `function_app_id` (an existing app), and exactly one of the two must be set. An active slot takes `slot_key` or `slot_id` the same way.

## Inputs

All inputs are required (no defaults): pass `{}` for a map you do not need. Context inputs (`enabled`, `namespace`, `environment`, `stage`, `name`, `attributes`, `tags`, ...) are declared in `_context.tf`.

| Name | Type | Description |
|------|------|-------------|
| `resource_group_name` | `string` | The resource group in which the apps are created. |
| `location` | `string` | The Azure region in which the apps are created. |
| `linux_function_apps` | `map(object)` | Map of `azurerm_linux_function_app`. |
| `windows_function_apps` | `map(object)` | Map of `azurerm_windows_function_app`. |
| `flex_consumption_function_apps` | `map(object)` | Map of `azurerm_function_app_flex_consumption`. |
| `linux_function_app_slots` | `map(object)` | Map of `azurerm_linux_function_app_slot`. |
| `windows_function_app_slots` | `map(object)` | Map of `azurerm_windows_function_app_slot`. |
| `function_app_active_slots` | `map(object)` | Map of `azurerm_function_app_active_slot`. |
| `function_app_connections` | `map(object)` | Map of `azurerm_function_app_connection`. |
| `function_app_functions` | `map(object)` | Map of `azurerm_function_app_function`. |
| `function_app_hybrid_connections` | `map(object)` | Map of `azurerm_function_app_hybrid_connection`. |
| `static_web_app_function_app_registrations` | `map(object)` | Map of `azurerm_static_web_app_function_app_registration`. |

Each map value is a typed object whose attributes follow the azurerm documentation for that resource (linked above). `name`, `tags`, `resource_group_name` and `location` are not attributes of the objects, because the module supplies them. Deprecated azurerm arguments are not exposed. Attributes the resource treats as optional may be omitted. Secrets such as `storage_account_access_key` and connection string values are marked sensitive by the provider, so they are masked in plan output; prefer Key Vault references in `app_settings`.

## Outputs

Each output is a map keyed like the matching input, holding the computed attributes of every instance (`id`, `default_hostname`, `identity`, ...). Site credentials and keys are deliberately not output.

| Name | Description |
|------|-------------|
| `linux_function_apps` | Attributes of each `azurerm_linux_function_app`, keyed like the input. |
| `windows_function_apps` | Attributes of each `azurerm_windows_function_app`, keyed like the input. |
| `flex_consumption_function_apps` | Attributes of each `azurerm_function_app_flex_consumption`, keyed like the input. |
| `linux_function_app_slots` | Attributes of each `azurerm_linux_function_app_slot`, keyed like the input. |
| `windows_function_app_slots` | Attributes of each `azurerm_windows_function_app_slot`, keyed like the input. |
| `function_app_active_slots` | Attributes of each `azurerm_function_app_active_slot`, keyed like the input. |
| `function_app_connections` | Attributes of each `azurerm_function_app_connection`, keyed like the input. |
| `function_app_functions` | Attributes of each `azurerm_function_app_function`, keyed like the input. |
| `function_app_hybrid_connections` | Attributes of each `azurerm_function_app_hybrid_connection`, keyed like the input. |
| `static_web_app_function_app_registrations` | Attributes of each `azurerm_static_web_app_function_app_registration`, keyed like the input. |

## Usage

```hcl
terraform {
  source = "git::https://github.com/raringgroup/terraform-azurerm-function-app.git?ref=develop"
}

inputs = {
  enabled     = true
  namespace   = "<namespace>"
  environment = "<environment>"
  label_order = ["namespace", "environment", "name", "attributes"]

  resource_group_name = "<resource-group>"
  location            = "<azure-region>"

  linux_function_apps = {
    api = {
      https_only                 = true
      service_plan_id            = "<service-plan-id>"
      storage_account_access_key = "<storage-account-access-key>"
      storage_account_name       = "<storage-account-name>"

      site_config = {
        application_stack = {
          python_version = "3.11"
        }
      }
    }
  }

  linux_function_app_slots = {
    staging = {
      function_app_key           = "api"
      storage_account_access_key = "<storage-account-access-key>"
      storage_account_name       = "<storage-account-name>"
      site_config                = {}
    }
  }

  windows_function_apps                     = {}
  flex_consumption_function_apps            = {}
  windows_function_app_slots                = {}
  function_app_active_slots                 = {}
  function_app_connections                  = {}
  function_app_functions                    = {}
  function_app_hybrid_connections           = {}
  static_web_app_function_app_registrations = {}
}
```

## Examples

Each example is self-contained: it creates its own resource group, storage account and service plan, then calls the module with `source = "../../"`. Each has a `terragrunt.hcl` that generates the provider and backend.

| Example | Scenario |
|---------|----------|
| [`complete`](examples/complete) | One Linux app with a slot, one Windows app and one Flex Consumption app together. |
| [`linux-app`](examples/linux-app) | A Linux function app on the Consumption plan (Y1) with a system-assigned managed identity, app settings and CORS. |
| [`windows-slots`](examples/windows-slots) | A Windows function app on Elastic Premium (EP1) with a staging slot and an active-slot swap. Slots need a plan that supports them, so Consumption cannot be used. |
| [`flex-consumption`](examples/flex-consumption) | A Flex Consumption app (FC1) with always-ready instances, a deployment container and a managed identity. |
| [`existing-function-app`](examples/existing-function-app) | Adds a slot and a function to a function app that already exists, referring to it by `function_app_id` instead of by key. |

## License

Apache License 2.0. Copyright 2026 Raring Group LLC.
