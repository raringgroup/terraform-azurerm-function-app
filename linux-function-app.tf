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
##  linux-function-app.tf
##
##  Linux function apps (azurerm_linux_function_app), named from the context module.
## ----------------------------------------------------------------------------

## Linux Function App Context
module "linux_function_app_context" {
  for_each = module.context.enabled ? var.linux_function_apps : {}

  source  = "git::https://github.com/raringgroup/terraform-null-context.git?ref=v0.1.0"
  context = module.context.self

  name = each.key
}


## Linux Function Apps
resource "azurerm_linux_function_app" "this" {
  for_each = module.context.enabled ? var.linux_function_apps : {}

  name                                           = coalesce(each.value.name, module.linux_function_app_context[each.key].id)
  tags                                           = module.linux_function_app_context[each.key].tags
  resource_group_name                            = var.resource_group_name
  location                                       = var.location
  app_settings                                   = each.value.app_settings
  builtin_logging_enabled                        = each.value.builtin_logging_enabled
  client_certificate_enabled                     = each.value.client_certificate_enabled
  client_certificate_exclusion_paths             = each.value.client_certificate_exclusion_paths
  client_certificate_mode                        = each.value.client_certificate_mode
  content_share_force_disabled                   = each.value.content_share_force_disabled
  daily_memory_time_quota                        = each.value.daily_memory_time_quota
  enabled                                        = each.value.enabled
  ftp_publish_basic_authentication_enabled       = each.value.ftp_publish_basic_authentication_enabled
  functions_extension_version                    = each.value.functions_extension_version
  https_only                                     = each.value.https_only
  key_vault_reference_identity_id                = each.value.key_vault_reference_identity_id
  public_network_access_enabled                  = each.value.public_network_access_enabled
  service_plan_id                                = each.value.service_plan_id
  storage_account_access_key                     = each.value.storage_account_access_key
  storage_account_name                           = each.value.storage_account_name
  storage_key_vault_secret_id                    = each.value.storage_key_vault_secret_id
  storage_uses_managed_identity                  = each.value.storage_uses_managed_identity
  virtual_network_backup_restore_enabled         = each.value.virtual_network_backup_restore_enabled
  virtual_network_subnet_id                      = each.value.virtual_network_subnet_id
  vnet_image_pull_enabled                        = each.value.vnet_image_pull_enabled
  webdeploy_publish_basic_authentication_enabled = each.value.webdeploy_publish_basic_authentication_enabled
  zip_deploy_file                                = each.value.zip_deploy_file

  dynamic "auth_settings" {
    for_each = each.value.auth_settings == null ? [] : [each.value.auth_settings]
    content {
      additional_login_parameters    = auth_settings.value.additional_login_parameters
      allowed_external_redirect_urls = auth_settings.value.allowed_external_redirect_urls
      default_provider               = auth_settings.value.default_provider
      enabled                        = auth_settings.value.enabled
      issuer                         = auth_settings.value.issuer
      runtime_version                = auth_settings.value.runtime_version
      token_refresh_extension_hours  = auth_settings.value.token_refresh_extension_hours
      token_store_enabled            = auth_settings.value.token_store_enabled
      unauthenticated_client_action  = auth_settings.value.unauthenticated_client_action

      dynamic "active_directory" {
        for_each = auth_settings.value.active_directory == null ? [] : [auth_settings.value.active_directory]
        content {
          allowed_audiences          = active_directory.value.allowed_audiences
          client_id                  = active_directory.value.client_id
          client_secret              = active_directory.value.client_secret
          client_secret_setting_name = active_directory.value.client_secret_setting_name
        }
      }

      dynamic "facebook" {
        for_each = auth_settings.value.facebook == null ? [] : [auth_settings.value.facebook]
        content {
          app_id                  = facebook.value.app_id
          app_secret              = facebook.value.app_secret
          app_secret_setting_name = facebook.value.app_secret_setting_name
          oauth_scopes            = facebook.value.oauth_scopes
        }
      }

      dynamic "github" {
        for_each = auth_settings.value.github == null ? [] : [auth_settings.value.github]
        content {
          client_id                  = github.value.client_id
          client_secret              = github.value.client_secret
          client_secret_setting_name = github.value.client_secret_setting_name
          oauth_scopes               = github.value.oauth_scopes
        }
      }

      dynamic "google" {
        for_each = auth_settings.value.google == null ? [] : [auth_settings.value.google]
        content {
          client_id                  = google.value.client_id
          client_secret              = google.value.client_secret
          client_secret_setting_name = google.value.client_secret_setting_name
          oauth_scopes               = google.value.oauth_scopes
        }
      }

      dynamic "microsoft" {
        for_each = auth_settings.value.microsoft == null ? [] : [auth_settings.value.microsoft]
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = microsoft.value.client_secret
          client_secret_setting_name = microsoft.value.client_secret_setting_name
          oauth_scopes               = microsoft.value.oauth_scopes
        }
      }

      dynamic "twitter" {
        for_each = auth_settings.value.twitter == null ? [] : [auth_settings.value.twitter]
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = twitter.value.consumer_secret
          consumer_secret_setting_name = twitter.value.consumer_secret_setting_name
        }
      }
    }
  }

  dynamic "auth_settings_v2" {
    for_each = each.value.auth_settings_v2 == null ? [] : [each.value.auth_settings_v2]
    content {
      auth_enabled                            = auth_settings_v2.value.auth_enabled
      config_file_path                        = auth_settings_v2.value.config_file_path
      default_provider                        = auth_settings_v2.value.default_provider
      excluded_paths                          = auth_settings_v2.value.excluded_paths
      forward_proxy_convention                = auth_settings_v2.value.forward_proxy_convention
      forward_proxy_custom_host_header_name   = auth_settings_v2.value.forward_proxy_custom_host_header_name
      forward_proxy_custom_scheme_header_name = auth_settings_v2.value.forward_proxy_custom_scheme_header_name
      http_route_api_prefix                   = auth_settings_v2.value.http_route_api_prefix
      require_authentication                  = auth_settings_v2.value.require_authentication
      require_https                           = auth_settings_v2.value.require_https
      runtime_version                         = auth_settings_v2.value.runtime_version
      unauthenticated_action                  = auth_settings_v2.value.unauthenticated_action

      dynamic "active_directory_v2" {
        for_each = auth_settings_v2.value.active_directory_v2 == null ? [] : [auth_settings_v2.value.active_directory_v2]
        content {
          allowed_applications                 = active_directory_v2.value.allowed_applications
          allowed_audiences                    = active_directory_v2.value.allowed_audiences
          allowed_groups                       = active_directory_v2.value.allowed_groups
          allowed_identities                   = active_directory_v2.value.allowed_identities
          client_id                            = active_directory_v2.value.client_id
          client_secret_certificate_thumbprint = active_directory_v2.value.client_secret_certificate_thumbprint
          client_secret_setting_name           = active_directory_v2.value.client_secret_setting_name
          jwt_allowed_client_applications      = active_directory_v2.value.jwt_allowed_client_applications
          jwt_allowed_groups                   = active_directory_v2.value.jwt_allowed_groups
          login_parameters                     = active_directory_v2.value.login_parameters
          tenant_auth_endpoint                 = active_directory_v2.value.tenant_auth_endpoint
          www_authentication_disabled          = active_directory_v2.value.www_authentication_disabled
        }
      }

      dynamic "apple_v2" {
        for_each = auth_settings_v2.value.apple_v2 == null ? [] : [auth_settings_v2.value.apple_v2]
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = apple_v2.value.client_secret_setting_name
        }
      }

      dynamic "azure_static_web_app_v2" {
        for_each = auth_settings_v2.value.azure_static_web_app_v2 == null ? [] : [auth_settings_v2.value.azure_static_web_app_v2]
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = auth_settings_v2.value.custom_oidc_v2 == null ? [] : auth_settings_v2.value.custom_oidc_v2
        content {
          client_id                     = custom_oidc_v2.value.client_id
          name                          = custom_oidc_v2.value.name
          name_claim_type               = custom_oidc_v2.value.name_claim_type
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          scopes                        = custom_oidc_v2.value.scopes
        }
      }

      dynamic "facebook_v2" {
        for_each = auth_settings_v2.value.facebook_v2 == null ? [] : [auth_settings_v2.value.facebook_v2]
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = facebook_v2.value.graph_api_version
          login_scopes            = facebook_v2.value.login_scopes
        }
      }

      dynamic "github_v2" {
        for_each = auth_settings_v2.value.github_v2 == null ? [] : [auth_settings_v2.value.github_v2]
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = github_v2.value.login_scopes
        }
      }

      dynamic "google_v2" {
        for_each = auth_settings_v2.value.google_v2 == null ? [] : [auth_settings_v2.value.google_v2]
        content {
          allowed_audiences          = google_v2.value.allowed_audiences
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          login_scopes               = google_v2.value.login_scopes
        }
      }

      dynamic "login" {
        for_each = auth_settings_v2.value.login == null ? [] : [auth_settings_v2.value.login]
        content {
          allowed_external_redirect_urls    = login.value.allowed_external_redirect_urls
          cookie_expiration_convention      = login.value.cookie_expiration_convention
          cookie_expiration_time            = login.value.cookie_expiration_time
          logout_endpoint                   = login.value.logout_endpoint
          nonce_expiration_time             = login.value.nonce_expiration_time
          preserve_url_fragments_for_logins = login.value.preserve_url_fragments_for_logins
          token_refresh_extension_time      = login.value.token_refresh_extension_time
          token_store_enabled               = login.value.token_store_enabled
          token_store_path                  = login.value.token_store_path
          token_store_sas_setting_name      = login.value.token_store_sas_setting_name
          validate_nonce                    = login.value.validate_nonce
        }
      }

      dynamic "microsoft_v2" {
        for_each = auth_settings_v2.value.microsoft_v2 == null ? [] : [auth_settings_v2.value.microsoft_v2]
        content {
          allowed_audiences          = microsoft_v2.value.allowed_audiences
          client_id                  = microsoft_v2.value.client_id
          client_secret_setting_name = microsoft_v2.value.client_secret_setting_name
          login_scopes               = microsoft_v2.value.login_scopes
        }
      }

      dynamic "twitter_v2" {
        for_each = auth_settings_v2.value.twitter_v2 == null ? [] : [auth_settings_v2.value.twitter_v2]
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }
    }
  }

  dynamic "backup" {
    for_each = each.value.backup == null ? [] : [each.value.backup]
    content {
      enabled             = backup.value.enabled
      name                = backup.value.name
      storage_account_url = backup.value.storage_account_url

      dynamic "schedule" {
        for_each = backup.value.schedule == null ? [] : [backup.value.schedule]
        content {
          frequency_interval       = schedule.value.frequency_interval
          frequency_unit           = schedule.value.frequency_unit
          keep_at_least_one_backup = schedule.value.keep_at_least_one_backup
          retention_period_days    = schedule.value.retention_period_days
          start_time               = schedule.value.start_time
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = each.value.connection_string == null ? [] : each.value.connection_string
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = each.value.identity == null ? [] : [each.value.identity]
    content {
      identity_ids = identity.value.identity_ids
      type         = identity.value.type
    }
  }

  dynamic "site_config" {
    for_each = each.value.site_config == null ? [] : [each.value.site_config]
    content {
      always_on                                     = site_config.value.always_on
      api_definition_url                            = site_config.value.api_definition_url
      api_management_api_id                         = site_config.value.api_management_api_id
      app_command_line                              = site_config.value.app_command_line
      app_scale_limit                               = site_config.value.app_scale_limit
      application_insights_connection_string        = site_config.value.application_insights_connection_string
      application_insights_key                      = site_config.value.application_insights_key
      container_registry_managed_identity_client_id = site_config.value.container_registry_managed_identity_client_id
      container_registry_use_managed_identity       = site_config.value.container_registry_use_managed_identity
      default_documents                             = site_config.value.default_documents
      elastic_instance_minimum                      = site_config.value.elastic_instance_minimum
      ftps_state                                    = site_config.value.ftps_state
      health_check_eviction_time_in_min             = site_config.value.health_check_eviction_time_in_min
      health_check_path                             = site_config.value.health_check_path
      http2_enabled                                 = site_config.value.http2_enabled
      ip_restriction_default_action                 = site_config.value.ip_restriction_default_action
      load_balancing_mode                           = site_config.value.load_balancing_mode
      managed_pipeline_mode                         = site_config.value.managed_pipeline_mode
      minimum_tls_cipher_suite                      = site_config.value.minimum_tls_cipher_suite
      minimum_tls_version                           = site_config.value.minimum_tls_version
      pre_warmed_instance_count                     = site_config.value.pre_warmed_instance_count
      remote_debugging_enabled                      = site_config.value.remote_debugging_enabled
      remote_debugging_version                      = site_config.value.remote_debugging_version
      runtime_scale_monitoring_enabled              = site_config.value.runtime_scale_monitoring_enabled
      scm_ip_restriction_default_action             = site_config.value.scm_ip_restriction_default_action
      scm_minimum_tls_version                       = site_config.value.scm_minimum_tls_version
      scm_use_main_ip_restriction                   = site_config.value.scm_use_main_ip_restriction
      use_32_bit_worker                             = site_config.value.use_32_bit_worker
      vnet_route_all_enabled                        = site_config.value.vnet_route_all_enabled
      websockets_enabled                            = site_config.value.websockets_enabled
      worker_count                                  = site_config.value.worker_count

      dynamic "app_service_logs" {
        for_each = site_config.value.app_service_logs == null ? [] : [site_config.value.app_service_logs]
        content {
          disk_quota_mb         = app_service_logs.value.disk_quota_mb
          retention_period_days = app_service_logs.value.retention_period_days
        }
      }

      dynamic "application_stack" {
        for_each = site_config.value.application_stack == null ? [] : [site_config.value.application_stack]
        content {
          dotnet_version              = application_stack.value.dotnet_version
          java_version                = application_stack.value.java_version
          node_version                = application_stack.value.node_version
          powershell_core_version     = application_stack.value.powershell_core_version
          python_version              = application_stack.value.python_version
          use_custom_runtime          = application_stack.value.use_custom_runtime
          use_dotnet_isolated_runtime = application_stack.value.use_dotnet_isolated_runtime

          dynamic "docker" {
            for_each = application_stack.value.docker == null ? [] : application_stack.value.docker
            content {
              image_name        = docker.value.image_name
              image_tag         = docker.value.image_tag
              registry_password = docker.value.registry_password
              registry_url      = docker.value.registry_url
              registry_username = docker.value.registry_username
            }
          }
        }
      }

      dynamic "cors" {
        for_each = site_config.value.cors == null ? [] : [site_config.value.cors]
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = cors.value.support_credentials
        }
      }

      dynamic "ip_restriction" {
        for_each = site_config.value.ip_restriction == null ? [] : site_config.value.ip_restriction
        content {
          action                    = ip_restriction.value.action
          description               = ip_restriction.value.description
          headers                   = ip_restriction.value.headers
          ip_address                = ip_restriction.value.ip_address
          name                      = ip_restriction.value.name
          priority                  = ip_restriction.value.priority
          service_tag               = ip_restriction.value.service_tag
          virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = site_config.value.scm_ip_restriction == null ? [] : site_config.value.scm_ip_restriction
        content {
          action                    = scm_ip_restriction.value.action
          description               = scm_ip_restriction.value.description
          headers                   = scm_ip_restriction.value.headers
          ip_address                = scm_ip_restriction.value.ip_address
          name                      = scm_ip_restriction.value.name
          priority                  = scm_ip_restriction.value.priority
          service_tag               = scm_ip_restriction.value.service_tag
          virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
        }
      }
    }
  }

  dynamic "sticky_settings" {
    for_each = each.value.sticky_settings == null ? [] : [each.value.sticky_settings]
    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  dynamic "storage_account" {
    for_each = each.value.storage_account == null ? [] : each.value.storage_account
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      mount_path   = storage_account.value.mount_path
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
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
}
