#--------------------------------------------------------------
# Genesis - Resource Group
#--------------------------------------------------------------

# Looking up Resource Group in hmcts-control

variable "environment" {
  type = string
}

variable "hmcts_access_vault" {}
variable "remote_state_storage_account_name" {}

data "azurerm_resource_group" "hmcts_control_resource_group" {
  name = "azure-control-sbox-rg"
}

output "value" {
  value = data.azurerm_resource_group.hmcts_control_resource_group.name
}

data "azurerm_storage_account" "terraform_storage_account" {
  name                = var.remote_state_storage_account_name
  resource_group_name = "azure-control-${var.environment}-rg"
}

data "azurerm_key_vault" "key_vault" {
  name                = var.hmcts_access_vault
  resource_group_name = data.azurerm_resource_group.hmcts_control_resource_group.name
}

resource "azurerm_key_vault_secret" "terraform_remote_state_storage_account_access_key" {
  name         = "terraform-remote-state-storage-account-access-key"
  value        = data.azurerm_storage_account.terraform_storage_account.primary_access_key
  key_vault_id = azurerm_key_vault.key_vault.id
}



# resource "azurerm_resource_group" "genesis_resource_group" {
#   location = var.location

#   name = "genesis_resource_group"
# }

# resource "random_id" "random_id" {
#   keepers = {
#     subscription_id = element(split("/", data.azurerm_subscription.current.id), 1)
#   }

#   byte_length = 6
# }
