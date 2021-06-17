data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azuread_group" "operations_group" {
  name = "DTS Operations (env:${var.environment})"
}
data "azuread_group" "aad_group" {
  name = "DTS Contributors (sub:dts-sharedservices-${var.environment})"
}
data "azuread_group" "platform_group" {
  name = "DTS Platform Operations"
}
data "azuread_group" "developers_group" {
  name = var.developers_group
}

data "azuread_group" "aks-sbox-mi" {
  name = var.aks-sbox-mi
}