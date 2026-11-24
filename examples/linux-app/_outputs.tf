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
##  examples/linux-app/_outputs.tf
##
##  Outputs of the example. The name output asserts the name the example builds.
## ----------------------------------------------------------------------------

output "linux_function_apps" {
  value = module.function_app.linux_function_apps
}

output "name" {
  value = module.function_app.linux_function_apps["api"].name

  precondition {
    condition     = module.function_app.linux_function_apps["api"].name == "fa-rg-function-app-api"
    error_message = "The app must be named fa-rg-function-app-api: the fa attribute first, then the namespace, the project and the app key."
  }
}
