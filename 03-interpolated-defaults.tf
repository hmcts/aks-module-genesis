locals {

  sub_env        = var.environment == "ptlsbox" ? "ptl-sbox" : var.environment
  
  aad_group_name = var.environment == "ptl" && local.project == "cft" ? "DTS Contributors (sub:dts-cftptl-intsvc)" : (var.environment == "ptlsbox" && local.project == "cft" ? "DTS Contributors (sub:dts-cftsbox-intsvc)" : var.environment == "ptl" && local.project == "sds" ? "DTS Contributors (sub:dts-sharedservicesptl)" : (var.environment == "ptlsbox" && local.project == "sds" ? "DTS Contributors (sub:dts-sharedservicesptl-sbox)" : (!contains(["ptl","ptlsbox"], var.environment) && local.project == "sds" ? "DTS Contributors (sub:dts-sharedservicesptl-sbox)" : "DTS Contributors (sub:dcd-cftapps-${local.sub_env})")))

  project = length(regexall(".*cft*.", lower(data.azurerm_subscription.current.display_name))) > 0 ? "cft" : "sds"

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
