#--------------------------------------------------------------
# Genesis - Infrastructure Key Vault - Seed Data
#--------------------------------------------------------------

resource "azurerm_key_vault_secret" "terraform_remote_state_storage_account_access_key" {
  name      = "terraform-remote-state-storage-account-access-key"
  value     = "${azurerm_storage_account.terraform_storage_account.primary_access_key}"
  vault_uri = "${azurerm_key_vault.key_vault.vault_uri}"
}
