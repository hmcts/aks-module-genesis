locals {

  sub_env        = var.environment == "ptlsbox" ? "ptl-sbox" : var.environment
  
  aad_group_name = var.environment == "ptl" && contains(["CFT"], data.azurerm_subscription.current.display_name) ? "DTS Contributors (sub:dts-cftptl-intsvc)" : (var.environment == "ptlsbox" && contains(["CFT"], data.azurerm_subscription.current.display_name) ? "DTS Contributors (sub:dts-cftsbox-intsvc)" : var.environment == "ptl" && contains(["SHAREDSERVICES"], data.azurerm_subscription.current.display_name) ? "DTS Contributors (sub:dts-sharedservicesptl)" : (var.environment == "ptlsbox" && contains(["SHAREDSERVICES"], data.azurerm_subscription.current.display_name) ? "DTS Contributors (sub:dts-sharedservicesptl-sbox)" : (!contains(["ptl","ptlsbox"], var.environment) && contains(["SHAREDSERVICES"], data.azurerm_subscription.current.display_name) ? "DTS Contributors (sub:dts-sharedservicesptl-sbox)" : "DTS Contributors (sub:dts-cftapps-${local.sub_env})")))

  project = length(regexall(".*sds.*", lower(var.developers_group))) > 0 ? "sds" : "cft"

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
  display_name = var.developers_group
}
