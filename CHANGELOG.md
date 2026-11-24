# Changelog

## v0.1.1 (breaking change)

### Breaking change

- The module no longer adds the attribute `func` to the generated function app name. The three inner context calls (`linux_function_app_context`, `windows_function_app_context` and `flex_consumption_function_app_context`) now set only `name = each.key`. Callers pass attributes, `label_order`, `delimiter` and so on through the module context inputs.
- **Effect:** generated names no longer contain `func`. For the same inputs, `example-dev-api-func` becomes `example-dev-api`. Callers that rely on the generated name will see their apps renamed. Changing the name of a function app forces a new resource, so Terraform replaces the app (destroy and create), its default hostname changes, and the slots, functions and connections that point at it are replaced with it.
- **To keep the old names**, pass `attributes = ["func"]` (the module appended `func` after the caller attributes, so this reproduces the v0.1.0 names for the same `label_order`), or set the optional `name` on an app to its current name. Check the plan before applying.
- Tags still come from each app inner context. Without attributes the `Attributes` tag is no longer set on the apps.

### Added

- `name` in the `linux_function_apps`, `windows_function_apps` and `flex_consumption_function_apps` outputs: the final app name.
- Tests for caller-controlled names (including `fa-example-dev-demo-sync-<app>` for all three app kinds), for restoring the old names with `attributes = ["func"]`, and for the tags.

### Changed

- The `complete`, `windows-slots` and `flex-consumption` examples pass `attributes = ["func"]` to keep the names the previous version generated. The `linux-app` example passes `attributes = ["fa"]` with a `label_order` that puts it first, and asserts the resulting name (`fa-<namespace>-<project>-api`) in its outputs.
- Existing tests expect the new names and tags.
- README: naming rules, upgrade notes, the `name` output, usage and the examples list.

## v0.1.0

- Initial release.
