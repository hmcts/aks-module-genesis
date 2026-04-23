locals {

  sub_env        = var.environment == "ptlsbox" ? "ptl-sbox" : var.environment
  
  aad_group_name = contains(["ptlsbox", "ptl"], var.environment) ? local.contributors_group["${local.business_area}-${var.environment}"] : local.contributors_group["${local.business_area}-env"]

  contributors_group = {
    "cft-ptl" = "DTS Contributors (sub:dts-cftptl-intsvc)"
    "cft-ptlsbox" = "DTS Contributors (sub:dts-cftsbox-intsvc)" 
    "cft-env" = "DTS Contributors (sub:dcd-cftapps-${local.sub_env})"
    "sds-ptl" = "DTS Contributors (sub:dts-sharedservicesptl)"
    "sds-ptlsbox" = "DTS Contributors (sub:dts-sharedservicesptl-sbox)"
    "sds-env" = "DTS Contributors (sub:dts-sharedservices-${local.sub_env})"
  }

  business_area = var.business_area == "cross-cutting" ? "sds" : var.business_area

}

provider "azurerm" {
  alias           = "jenkins-azurerm"
  features {}
  subscription_id = var.jenkins_provider_sub_id
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

data "azurerm_user_assigned_identity" "jenkins" {
  provider            = azurerm.jenkins-azurerm
  name                = var.jenkins_mi_name
  resource_group_name = var.jenkins_mi_rg_name
}