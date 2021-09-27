locals {

  sub_env        = var.environment == "ptlsbox" ? "ptl-sbox" : var.environment
  aad_group_name = contains(["ptlsbox", "ptl"], var.environment) ? "DTS Contributors (sub:dts-sharedservices${local.sub_env})" : "DTS Contributors (sub:dts-sharedservices-${local.sub_env})"

}
data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azuread_group" "operations_group" {
  display_name = "DTS Operations (env:${var.environment})"
}
data "azuread_group" "aad_group" {
  display_name = local.aad_group_name
}
data "azuread_group" "platform_group" {
  display_name     = "DTS Platform Operations"
  security_enabled = true
}
data "azuread_group" "developers_group" {
  display_name = "DTS SDS Developers"
}
