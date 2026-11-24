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
##  _variables.tf
##
##  Input variables. The module-level inputs apply to every function app; each map creates one resource type.
## ----------------------------------------------------------------------------

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the function apps are created."
}

variable "location" {
  type        = string
  description = "The Azure region in which the function apps are created."
}

variable "linux_function_apps" {
  type = map(object({
    app_settings                                   = optional(map(string))
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    content_share_force_disabled                   = optional(bool)
    daily_memory_time_quota                        = optional(number)
    enabled                                        = optional(bool)
    name                                           = optional(string)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    functions_extension_version                    = optional(string)
    https_only                                     = optional(bool)
    key_vault_reference_identity_id                = optional(string)
    public_network_access_enabled                  = optional(bool)
    service_plan_id                                = string
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    storage_uses_managed_identity                  = optional(bool)
    virtual_network_backup_restore_enabled         = optional(bool)
    virtual_network_subnet_id                      = optional(string)
    vnet_image_pull_enabled                        = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    zip_deploy_file                                = optional(string)
    auth_settings = optional(object({
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      enabled                        = bool
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(bool)
      unauthenticated_client_action  = optional(string)
      active_directory = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
      }))
      facebook = optional(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      }))
      github = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      google = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      microsoft = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      twitter = optional(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      }))
    }))
    auth_settings_v2 = optional(object({
      auth_enabled                            = optional(bool)
      config_file_path                        = optional(string)
      default_provider                        = optional(string)
      excluded_paths                          = optional(list(string))
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      http_route_api_prefix                   = optional(string)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      unauthenticated_action                  = optional(string)
      active_directory_v2 = optional(object({
        allowed_applications                 = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_identities                   = optional(list(string))
        client_id                            = string
        client_secret_certificate_thumbprint = optional(string)
        client_secret_setting_name           = optional(string)
        jwt_allowed_client_applications      = optional(list(string))
        jwt_allowed_groups                   = optional(list(string))
        login_parameters                     = optional(map(string))
        tenant_auth_endpoint                 = string
        www_authentication_disabled          = optional(bool)
      }))
      apple_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
      }))
      azure_static_web_app_v2 = optional(object({
        client_id = string
      }))
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        name_claim_type               = optional(string)
        openid_configuration_endpoint = string
        scopes                        = optional(list(string))
      })))
      facebook_v2 = optional(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      }))
      github_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      google_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      login = object({
        allowed_external_redirect_urls    = optional(list(string))
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        logout_endpoint                   = optional(string)
        nonce_expiration_time             = optional(string)
        preserve_url_fragments_for_logins = optional(bool)
        token_refresh_extension_time      = optional(number)
        token_store_enabled               = optional(bool)
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        validate_nonce                    = optional(bool)
      })
      microsoft_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      twitter_v2 = optional(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      }))
    }))
    backup = optional(object({
      enabled             = optional(bool)
      name                = string
      storage_account_url = string
      schedule = object({
        frequency_interval       = number
        frequency_unit           = string
        keep_at_least_one_backup = optional(bool)
        retention_period_days    = optional(number)
        start_time               = optional(string)
      })
    }))
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    site_config = object({
      always_on                                     = optional(bool)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      app_command_line                              = optional(string)
      app_scale_limit                               = optional(number)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      container_registry_use_managed_identity       = optional(bool)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      ftps_state                                    = optional(string)
      health_check_eviction_time_in_min             = optional(number)
      health_check_path                             = optional(string)
      http2_enabled                                 = optional(bool)
      ip_restriction_default_action                 = optional(string)
      load_balancing_mode                           = optional(string)
      managed_pipeline_mode                         = optional(string)
      minimum_tls_cipher_suite                      = optional(string)
      minimum_tls_version                           = optional(string)
      pre_warmed_instance_count                     = optional(number)
      remote_debugging_enabled                      = optional(bool)
      remote_debugging_version                      = optional(string)
      runtime_scale_monitoring_enabled              = optional(bool)
      scm_ip_restriction_default_action             = optional(string)
      scm_minimum_tls_version                       = optional(string)
      scm_use_main_ip_restriction                   = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      worker_count                                  = optional(number)
      app_service_logs = optional(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      }))
      application_stack = optional(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        powershell_core_version     = optional(string)
        python_version              = optional(string)
        use_custom_runtime          = optional(bool)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_password = optional(string)
          registry_url      = string
          registry_username = optional(string)
        })))
      }))
      cors = optional(object({
        allowed_origins     = optional(set(string))
        support_credentials = optional(bool)
      }))
      ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
    })
    sticky_settings = optional(object({
      app_setting_names       = optional(list(string))
      connection_string_names = optional(list(string))
    }))
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      mount_path   = optional(string)
      name         = string
      share_name   = string
      type         = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_linux_function_app resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app); tags, resource_group_name and location come from the module, and the name is generated from the context and the map key unless you set the optional name attribute to use a fixed name instead. Pass {} for none."
}

variable "windows_function_apps" {
  type = map(object({
    app_settings                                   = optional(map(string))
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    content_share_force_disabled                   = optional(bool)
    daily_memory_time_quota                        = optional(number)
    enabled                                        = optional(bool)
    name                                           = optional(string)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    functions_extension_version                    = optional(string)
    https_only                                     = optional(bool)
    key_vault_reference_identity_id                = optional(string)
    public_network_access_enabled                  = optional(bool)
    service_plan_id                                = string
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    storage_uses_managed_identity                  = optional(bool)
    virtual_network_backup_restore_enabled         = optional(bool)
    virtual_network_subnet_id                      = optional(string)
    vnet_image_pull_enabled                        = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    zip_deploy_file                                = optional(string)
    auth_settings = optional(object({
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      enabled                        = bool
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(bool)
      unauthenticated_client_action  = optional(string)
      active_directory = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
      }))
      facebook = optional(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      }))
      github = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      google = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      microsoft = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      twitter = optional(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      }))
    }))
    auth_settings_v2 = optional(object({
      auth_enabled                            = optional(bool)
      config_file_path                        = optional(string)
      default_provider                        = optional(string)
      excluded_paths                          = optional(list(string))
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      http_route_api_prefix                   = optional(string)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      unauthenticated_action                  = optional(string)
      active_directory_v2 = optional(object({
        allowed_applications                 = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_identities                   = optional(list(string))
        client_id                            = string
        client_secret_certificate_thumbprint = optional(string)
        client_secret_setting_name           = optional(string)
        jwt_allowed_client_applications      = optional(list(string))
        jwt_allowed_groups                   = optional(list(string))
        login_parameters                     = optional(map(string))
        tenant_auth_endpoint                 = string
        www_authentication_disabled          = optional(bool)
      }))
      apple_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
      }))
      azure_static_web_app_v2 = optional(object({
        client_id = string
      }))
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        name_claim_type               = optional(string)
        openid_configuration_endpoint = string
        scopes                        = optional(list(string))
      })))
      facebook_v2 = optional(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      }))
      github_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      google_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      login = object({
        allowed_external_redirect_urls    = optional(list(string))
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        logout_endpoint                   = optional(string)
        nonce_expiration_time             = optional(string)
        preserve_url_fragments_for_logins = optional(bool)
        token_refresh_extension_time      = optional(number)
        token_store_enabled               = optional(bool)
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        validate_nonce                    = optional(bool)
      })
      microsoft_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      twitter_v2 = optional(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      }))
    }))
    backup = optional(object({
      enabled             = optional(bool)
      name                = string
      storage_account_url = string
      schedule = object({
        frequency_interval       = number
        frequency_unit           = string
        keep_at_least_one_backup = optional(bool)
        retention_period_days    = optional(number)
        start_time               = optional(string)
      })
    }))
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    site_config = object({
      always_on                              = optional(bool)
      api_definition_url                     = optional(string)
      api_management_api_id                  = optional(string)
      app_command_line                       = optional(string)
      app_scale_limit                        = optional(number)
      application_insights_connection_string = optional(string)
      application_insights_key               = optional(string)
      default_documents                      = optional(list(string))
      elastic_instance_minimum               = optional(number)
      ftps_state                             = optional(string)
      health_check_eviction_time_in_min      = optional(number)
      health_check_path                      = optional(string)
      http2_enabled                          = optional(bool)
      ip_restriction_default_action          = optional(string)
      load_balancing_mode                    = optional(string)
      managed_pipeline_mode                  = optional(string)
      minimum_tls_cipher_suite               = optional(string)
      minimum_tls_version                    = optional(string)
      pre_warmed_instance_count              = optional(number)
      remote_debugging_enabled               = optional(bool)
      remote_debugging_version               = optional(string)
      runtime_scale_monitoring_enabled       = optional(bool)
      scm_ip_restriction_default_action      = optional(string)
      scm_minimum_tls_version                = optional(string)
      scm_use_main_ip_restriction            = optional(bool)
      use_32_bit_worker                      = optional(bool)
      vnet_route_all_enabled                 = optional(bool)
      websockets_enabled                     = optional(bool)
      worker_count                           = optional(number)
      app_service_logs = optional(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      }))
      application_stack = optional(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        powershell_core_version     = optional(string)
        use_custom_runtime          = optional(bool)
        use_dotnet_isolated_runtime = optional(bool)
      }))
      cors = optional(object({
        allowed_origins     = optional(set(string))
        support_credentials = optional(bool)
      }))
      ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
    })
    sticky_settings = optional(object({
      app_setting_names       = optional(list(string))
      connection_string_names = optional(list(string))
    }))
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      mount_path   = optional(string)
      name         = string
      share_name   = string
      type         = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_windows_function_app resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app); tags, resource_group_name and location come from the module, and the name is generated from the context and the map key unless you set the optional name attribute to use a fixed name instead. Pass {} for none."
}

variable "flex_consumption_function_apps" {
  type = map(object({
    app_settings                                   = optional(map(string))
    client_certificate_enabled                     = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    enabled                                        = optional(bool)
    name                                           = optional(string)
    http_concurrency                               = optional(number)
    https_only                                     = optional(bool)
    instance_memory_in_mb                          = optional(number)
    maximum_instance_count                         = optional(number)
    public_network_access_enabled                  = optional(bool)
    runtime_name                                   = string
    runtime_version                                = string
    service_plan_id                                = string
    storage_access_key                             = optional(string)
    storage_authentication_type                    = string
    storage_container_endpoint                     = string
    storage_container_type                         = string
    storage_user_assigned_identity_id              = optional(string)
    virtual_network_subnet_id                      = optional(string)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    zip_deploy_file                                = optional(string)
    always_ready = optional(list(object({
      instance_count = optional(number)
      name           = string
    })))
    auth_settings = optional(object({
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      enabled                        = bool
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(bool)
      unauthenticated_client_action  = optional(string)
      active_directory = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
      }))
      facebook = optional(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      }))
      github = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      google = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      microsoft = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      twitter = optional(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      }))
    }))
    auth_settings_v2 = optional(object({
      auth_enabled                            = optional(bool)
      config_file_path                        = optional(string)
      default_provider                        = optional(string)
      excluded_paths                          = optional(list(string))
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      http_route_api_prefix                   = optional(string)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      unauthenticated_action                  = optional(string)
      active_directory_v2 = optional(object({
        allowed_applications                 = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_identities                   = optional(list(string))
        client_id                            = string
        client_secret_certificate_thumbprint = optional(string)
        client_secret_setting_name           = optional(string)
        jwt_allowed_client_applications      = optional(list(string))
        jwt_allowed_groups                   = optional(list(string))
        login_parameters                     = optional(map(string))
        tenant_auth_endpoint                 = string
        www_authentication_disabled          = optional(bool)
      }))
      apple_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
      }))
      azure_static_web_app_v2 = optional(object({
        client_id = string
      }))
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        name_claim_type               = optional(string)
        openid_configuration_endpoint = string
        scopes                        = optional(list(string))
      })))
      facebook_v2 = optional(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      }))
      github_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      google_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      login = object({
        allowed_external_redirect_urls    = optional(list(string))
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        logout_endpoint                   = optional(string)
        nonce_expiration_time             = optional(string)
        preserve_url_fragments_for_logins = optional(bool)
        token_refresh_extension_time      = optional(number)
        token_store_enabled               = optional(bool)
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        validate_nonce                    = optional(bool)
      })
      microsoft_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      twitter_v2 = optional(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      }))
    }))
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    site_config = object({
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      app_command_line                              = optional(string)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      container_registry_use_managed_identity       = optional(bool)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      health_check_eviction_time_in_min             = optional(number)
      health_check_path                             = optional(string)
      http2_enabled                                 = optional(bool)
      ip_restriction_default_action                 = optional(string)
      load_balancing_mode                           = optional(string)
      managed_pipeline_mode                         = optional(string)
      minimum_tls_version                           = optional(string)
      remote_debugging_enabled                      = optional(bool)
      remote_debugging_version                      = optional(string)
      runtime_scale_monitoring_enabled              = optional(bool)
      scm_ip_restriction_default_action             = optional(string)
      scm_minimum_tls_version                       = optional(string)
      scm_use_main_ip_restriction                   = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      worker_count                                  = optional(number)
      app_service_logs = optional(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      }))
      cors = optional(object({
        allowed_origins     = optional(set(string))
        support_credentials = optional(bool)
      }))
      ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
    })
    sticky_settings = optional(object({
      app_setting_names       = optional(list(string))
      connection_string_names = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_function_app_flex_consumption resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_flex_consumption); tags, resource_group_name and location come from the module, and the name is generated from the context and the map key unless you set the optional name attribute to use a fixed name instead. Pass {} for none."
}

variable "linux_function_app_slots" {
  type = map(object({
    app_settings                                   = optional(map(string))
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    content_share_force_disabled                   = optional(bool)
    daily_memory_time_quota                        = optional(number)
    enabled                                        = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    function_app_id                                = optional(string)
    function_app_key                               = optional(string)
    functions_extension_version                    = optional(string)
    https_only                                     = optional(bool)
    key_vault_reference_identity_id                = optional(string)
    public_network_access_enabled                  = optional(bool)
    service_plan_id                                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    storage_uses_managed_identity                  = optional(bool)
    virtual_network_backup_restore_enabled         = optional(bool)
    virtual_network_subnet_id                      = optional(string)
    vnet_image_pull_enabled                        = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    auth_settings = optional(object({
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      enabled                        = bool
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(bool)
      unauthenticated_client_action  = optional(string)
      active_directory = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
      }))
      facebook = optional(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      }))
      github = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      google = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      microsoft = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      twitter = optional(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      }))
    }))
    auth_settings_v2 = optional(object({
      auth_enabled                            = optional(bool)
      config_file_path                        = optional(string)
      default_provider                        = optional(string)
      excluded_paths                          = optional(list(string))
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      http_route_api_prefix                   = optional(string)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      unauthenticated_action                  = optional(string)
      active_directory_v2 = optional(object({
        allowed_applications                 = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_identities                   = optional(list(string))
        client_id                            = string
        client_secret_certificate_thumbprint = optional(string)
        client_secret_setting_name           = optional(string)
        jwt_allowed_client_applications      = optional(list(string))
        jwt_allowed_groups                   = optional(list(string))
        login_parameters                     = optional(map(string))
        tenant_auth_endpoint                 = string
        www_authentication_disabled          = optional(bool)
      }))
      apple_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
      }))
      azure_static_web_app_v2 = optional(object({
        client_id = string
      }))
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        name_claim_type               = optional(string)
        openid_configuration_endpoint = string
        scopes                        = optional(list(string))
      })))
      facebook_v2 = optional(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      }))
      github_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      google_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      login = object({
        allowed_external_redirect_urls    = optional(list(string))
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        logout_endpoint                   = optional(string)
        nonce_expiration_time             = optional(string)
        preserve_url_fragments_for_logins = optional(bool)
        token_refresh_extension_time      = optional(number)
        token_store_enabled               = optional(bool)
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        validate_nonce                    = optional(bool)
      })
      microsoft_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      twitter_v2 = optional(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      }))
    }))
    backup = optional(object({
      enabled             = optional(bool)
      name                = string
      storage_account_url = string
      schedule = object({
        frequency_interval       = number
        frequency_unit           = string
        keep_at_least_one_backup = optional(bool)
        retention_period_days    = optional(number)
        start_time               = optional(string)
      })
    }))
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    site_config = object({
      always_on                                     = optional(bool)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      app_command_line                              = optional(string)
      app_scale_limit                               = optional(number)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      auto_swap_slot_name                           = optional(string)
      container_registry_managed_identity_client_id = optional(string)
      container_registry_use_managed_identity       = optional(bool)
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      ftps_state                                    = optional(string)
      health_check_eviction_time_in_min             = optional(number)
      health_check_path                             = optional(string)
      http2_enabled                                 = optional(bool)
      ip_restriction_default_action                 = optional(string)
      load_balancing_mode                           = optional(string)
      managed_pipeline_mode                         = optional(string)
      minimum_tls_cipher_suite                      = optional(string)
      minimum_tls_version                           = optional(string)
      pre_warmed_instance_count                     = optional(number)
      remote_debugging_enabled                      = optional(bool)
      remote_debugging_version                      = optional(string)
      runtime_scale_monitoring_enabled              = optional(bool)
      scm_ip_restriction_default_action             = optional(string)
      scm_minimum_tls_version                       = optional(string)
      scm_use_main_ip_restriction                   = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      worker_count                                  = optional(number)
      app_service_logs = optional(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      }))
      application_stack = optional(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        powershell_core_version     = optional(string)
        python_version              = optional(string)
        use_custom_runtime          = optional(bool)
        use_dotnet_isolated_runtime = optional(bool)
        docker = optional(list(object({
          image_name        = string
          image_tag         = string
          registry_password = optional(string)
          registry_url      = string
          registry_username = optional(string)
        })))
      }))
      cors = optional(object({
        allowed_origins     = optional(set(string))
        support_credentials = optional(bool)
      }))
      ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
    })
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      mount_path   = optional(string)
      name         = string
      share_name   = string
      type         = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_linux_function_app_slot resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app_slot); name and tags come from the module. Pass {} for none. Set function_app_key to the key of a resource created by this module, or function_app_id to an existing ID (exactly one of them)."
}

variable "windows_function_app_slots" {
  type = map(object({
    app_settings                                   = optional(map(string))
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    client_certificate_exclusion_paths             = optional(string)
    client_certificate_mode                        = optional(string)
    content_share_force_disabled                   = optional(bool)
    daily_memory_time_quota                        = optional(number)
    enabled                                        = optional(bool)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    function_app_id                                = optional(string)
    function_app_key                               = optional(string)
    functions_extension_version                    = optional(string)
    https_only                                     = optional(bool)
    key_vault_reference_identity_id                = optional(string)
    public_network_access_enabled                  = optional(bool)
    service_plan_id                                = optional(string)
    storage_account_access_key                     = optional(string)
    storage_account_name                           = optional(string)
    storage_key_vault_secret_id                    = optional(string)
    storage_uses_managed_identity                  = optional(bool)
    virtual_network_backup_restore_enabled         = optional(bool)
    virtual_network_subnet_id                      = optional(string)
    vnet_image_pull_enabled                        = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    auth_settings = optional(object({
      additional_login_parameters    = optional(map(string))
      allowed_external_redirect_urls = optional(list(string))
      default_provider               = optional(string)
      enabled                        = bool
      issuer                         = optional(string)
      runtime_version                = optional(string)
      token_refresh_extension_hours  = optional(number)
      token_store_enabled            = optional(bool)
      unauthenticated_client_action  = optional(string)
      active_directory = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
      }))
      facebook = optional(object({
        app_id                  = string
        app_secret              = optional(string)
        app_secret_setting_name = optional(string)
        oauth_scopes            = optional(list(string))
      }))
      github = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      google = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      microsoft = optional(object({
        client_id                  = string
        client_secret              = optional(string)
        client_secret_setting_name = optional(string)
        oauth_scopes               = optional(list(string))
      }))
      twitter = optional(object({
        consumer_key                 = string
        consumer_secret              = optional(string)
        consumer_secret_setting_name = optional(string)
      }))
    }))
    auth_settings_v2 = optional(object({
      auth_enabled                            = optional(bool)
      config_file_path                        = optional(string)
      default_provider                        = optional(string)
      excluded_paths                          = optional(list(string))
      forward_proxy_convention                = optional(string)
      forward_proxy_custom_host_header_name   = optional(string)
      forward_proxy_custom_scheme_header_name = optional(string)
      http_route_api_prefix                   = optional(string)
      require_authentication                  = optional(bool)
      require_https                           = optional(bool)
      runtime_version                         = optional(string)
      unauthenticated_action                  = optional(string)
      active_directory_v2 = optional(object({
        allowed_applications                 = optional(list(string))
        allowed_audiences                    = optional(list(string))
        allowed_groups                       = optional(list(string))
        allowed_identities                   = optional(list(string))
        client_id                            = string
        client_secret_certificate_thumbprint = optional(string)
        client_secret_setting_name           = optional(string)
        jwt_allowed_client_applications      = optional(list(string))
        jwt_allowed_groups                   = optional(list(string))
        login_parameters                     = optional(map(string))
        tenant_auth_endpoint                 = string
        www_authentication_disabled          = optional(bool)
      }))
      apple_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
      }))
      azure_static_web_app_v2 = optional(object({
        client_id = string
      }))
      custom_oidc_v2 = optional(list(object({
        client_id                     = string
        name                          = string
        name_claim_type               = optional(string)
        openid_configuration_endpoint = string
        scopes                        = optional(list(string))
      })))
      facebook_v2 = optional(object({
        app_id                  = string
        app_secret_setting_name = string
        graph_api_version       = optional(string)
        login_scopes            = optional(list(string))
      }))
      github_v2 = optional(object({
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      google_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      login = object({
        allowed_external_redirect_urls    = optional(list(string))
        cookie_expiration_convention      = optional(string)
        cookie_expiration_time            = optional(string)
        logout_endpoint                   = optional(string)
        nonce_expiration_time             = optional(string)
        preserve_url_fragments_for_logins = optional(bool)
        token_refresh_extension_time      = optional(number)
        token_store_enabled               = optional(bool)
        token_store_path                  = optional(string)
        token_store_sas_setting_name      = optional(string)
        validate_nonce                    = optional(bool)
      })
      microsoft_v2 = optional(object({
        allowed_audiences          = optional(list(string))
        client_id                  = string
        client_secret_setting_name = string
        login_scopes               = optional(list(string))
      }))
      twitter_v2 = optional(object({
        consumer_key                 = string
        consumer_secret_setting_name = string
      }))
    }))
    backup = optional(object({
      enabled             = optional(bool)
      name                = string
      storage_account_url = string
      schedule = object({
        frequency_interval       = number
        frequency_unit           = string
        keep_at_least_one_backup = optional(bool)
        retention_period_days    = optional(number)
        start_time               = optional(string)
      })
    }))
    connection_string = optional(list(object({
      name  = string
      type  = string
      value = string
    })))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    site_config = object({
      always_on                              = optional(bool)
      api_definition_url                     = optional(string)
      api_management_api_id                  = optional(string)
      app_command_line                       = optional(string)
      app_scale_limit                        = optional(number)
      application_insights_connection_string = optional(string)
      application_insights_key               = optional(string)
      auto_swap_slot_name                    = optional(string)
      default_documents                      = optional(list(string))
      elastic_instance_minimum               = optional(number)
      ftps_state                             = optional(string)
      health_check_eviction_time_in_min      = optional(number)
      health_check_path                      = optional(string)
      http2_enabled                          = optional(bool)
      ip_restriction_default_action          = optional(string)
      load_balancing_mode                    = optional(string)
      managed_pipeline_mode                  = optional(string)
      minimum_tls_cipher_suite               = optional(string)
      minimum_tls_version                    = optional(string)
      pre_warmed_instance_count              = optional(number)
      remote_debugging_enabled               = optional(bool)
      remote_debugging_version               = optional(string)
      runtime_scale_monitoring_enabled       = optional(bool)
      scm_ip_restriction_default_action      = optional(string)
      scm_minimum_tls_version                = optional(string)
      scm_use_main_ip_restriction            = optional(bool)
      use_32_bit_worker                      = optional(bool)
      vnet_route_all_enabled                 = optional(bool)
      websockets_enabled                     = optional(bool)
      worker_count                           = optional(number)
      app_service_logs = optional(object({
        disk_quota_mb         = optional(number)
        retention_period_days = optional(number)
      }))
      application_stack = optional(object({
        dotnet_version              = optional(string)
        java_version                = optional(string)
        node_version                = optional(string)
        powershell_core_version     = optional(string)
        use_custom_runtime          = optional(bool)
        use_dotnet_isolated_runtime = optional(bool)
      }))
      cors = optional(object({
        allowed_origins     = optional(set(string))
        support_credentials = optional(bool)
      }))
      ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
      scm_ip_restriction = optional(list(object({
        action                    = optional(string)
        description               = optional(string)
        headers                   = optional(list(object({ x_azure_fdid = list(string), x_fd_health_probe = list(string), x_forwarded_for = list(string), x_forwarded_host = list(string) })))
        ip_address                = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
    })
    storage_account = optional(list(object({
      access_key   = string
      account_name = string
      mount_path   = optional(string)
      name         = string
      share_name   = string
      type         = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_windows_function_app_slot resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app_slot); name and tags come from the module. Pass {} for none. Set function_app_key to the key of a resource created by this module, or function_app_id to an existing ID (exactly one of them)."
}

variable "function_app_active_slots" {
  type = map(object({
    overwrite_network_config = optional(bool)
    slot_id                  = optional(string)
    slot_key                 = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_function_app_active_slot resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_active_slot). Pass {} for none. Set slot_key to the key of a resource created by this module, or slot_id to an existing ID (exactly one of them)."
}

variable "function_app_connections" {
  type = map(object({
    client_type        = optional(string)
    function_app_id    = optional(string)
    function_app_key   = optional(string)
    target_resource_id = string
    vnet_solution      = optional(string)
    authentication = object({
      certificate     = optional(string)
      client_id       = optional(string)
      name            = optional(string)
      principal_id    = optional(string)
      secret          = optional(string)
      subscription_id = optional(string)
      type            = string
    })
    secret_store = optional(object({
      key_vault_id = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_function_app_connection resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_connection); name and tags come from the module. Pass {} for none. Set function_app_key to the key of a resource created by this module, or function_app_id to an existing ID (exactly one of them)."
}

variable "function_app_functions" {
  type = map(object({
    config_json      = string
    enabled          = optional(bool)
    function_app_id  = optional(string)
    function_app_key = optional(string)
    language         = optional(string)
    test_data        = optional(string)
    file = optional(list(object({
      content = string
      name    = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_function_app_function resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_function); name and tags come from the module. Pass {} for none. Set function_app_key to the key of a resource created by this module, or function_app_id to an existing ID (exactly one of them)."
}

variable "function_app_hybrid_connections" {
  type = map(object({
    function_app_id  = optional(string)
    function_app_key = optional(string)
    hostname         = string
    port             = number
    relay_id         = string
    send_key_name    = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = "Map of azurerm_function_app_hybrid_connection resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_hybrid_connection). Pass {} for none. Set function_app_key to the key of a resource created by this module, or function_app_id to an existing ID (exactly one of them)."
}

variable "static_web_app_function_app_registrations" {
  type = map(object({
    function_app_id   = optional(string)
    function_app_key  = optional(string)
    static_web_app_id = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
    }))
  }))
  description = "Map of azurerm_static_web_app_function_app_registration resources to create, keyed by a short name. For the function app kinds the key becomes the name label of the generated name; for the other kinds it is the resource name where the resource has one. Each value takes the arguments of the resource (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app_function_app_registration). Pass {} for none. Set function_app_key to the key of a resource created by this module, or function_app_id to an existing ID (exactly one of them)."
}
