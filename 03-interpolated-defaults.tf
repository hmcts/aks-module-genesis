locals {
  environment = var.environment == "ptlsbox" ? "ptl-sbox" : var.environment
  
  # Temporary until all key vaults have been updated to use the naming convention
  key_vault_name = contains(["ptlsbox", "ptl"], var.environment) ? "dtssds${var.environment}" : "${lower(replace(data.azurerm_subscription.current.display_name, "-", ""))}kv"
  
}



data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azuread_group" "operations_group" {
  display_name = "DTS Operations (env:${var.environment})"
}
data "azuread_group" "aad_group" {
  display_name = "DTS Contributors (sub:dts-sharedservices-${local.environment})"
}
data "azuread_group" "platform_group" {
  display_name = "DTS Platform Operations"
}
data "azuread_group" "developers_group" {
  display_name = var.developers_group
}
