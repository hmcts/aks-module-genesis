#--------------------------------------------------------------
# Genesis - Infrastructure Key Vault
#--------------------------------------------------------------


resource "azurerm_key_vault" "key_vault" {
  name                = contains(["ptlsbox", "ptl"], var.environment) ? "dts${local.business_area}${replace(var.environment, "-", "")}" : "${lower(replace(data.azurerm_subscription.current.display_name, "-", ""))}kv"
  resource_group_name = azurerm_resource_group.genesis_resource_group.name
  location            = var.location

  sku_name = "standard"

  tenant_id = data.azurerm_client_config.current.tenant_id

  enabled_for_deployment          = "true"
  enabled_for_disk_encryption     = "true"
  enabled_for_template_deployment = "true"
  soft_delete_retention_days      = 30

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.aad_group.id

  key_permissions = [
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

resource "azurerm_key_vault_access_policy" "developers_group_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.developers_group.id

  key_permissions = [
    "Encrypt",
  ]

  secret_permissions = [
    "List",
    "Set",
  ]
}

resource "azurerm_key_vault_access_policy" "ops_group_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.operations_group.id

  key_permissions = [
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

resource "azurerm_key_vault_access_policy" "platform_operations" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.platform_group.id

  key_permissions = [
    "Create",
    "Delete",
    "Encrypt",
    "Decrypt",
    "Get",
    "Import",
    "List",
    "Recover",
    "Restore",
    "Update",
    "Backup",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Recover",
    "Restore",
    "Set",
  ]

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update"
  ]
}

