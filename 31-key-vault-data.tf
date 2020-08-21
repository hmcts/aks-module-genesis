#--------------------------------------------------------------
# Genesis - Infrastructure Key Vault - Seed Data
#--------------------------------------------------------------

resource "azurerm_key_vault_secret" "terraform_remote_state_storage_account_access_key" {
  count = contains(var.features, "key_vault") && contains(var.features, "storage_account") ? 1 : 0

  name         = "terraform-remote-state-storage-account-access-key"
  value        = azurerm_storage_account.terraform_storage_account[0].primary_access_key
  key_vault_id = azurerm_key_vault.key_vault[0].id
}
