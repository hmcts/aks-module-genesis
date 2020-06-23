data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azuread_group" "operations_group" {
  name = "dcd_sp_ado_${var.environment}_operations_v2"
}

