data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azuread_group" "operations_group" {
  display_name = "DTS Operations (env:${var.environment})"
}
data "azuread_group" "aad_group" {
  display_name = "DTS Contributors (sub:dts-sharedservices-${var.environment})"
}
data "azuread_group" "platform_group" {
  object_id = "e7ea2042-4ced-45dd-8ae3-e051c6551789"
}
data "azuread_group" "developers_group" {
  display_name = var.developers_group
}
