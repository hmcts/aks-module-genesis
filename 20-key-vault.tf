#--------------------------------------------------------------
# Genesis - Infrastructure Key Vault
#--------------------------------------------------------------


resource "azurerm_key_vault" "key_vault" {
  name                = "${lower(replace(data.azurerm_subscription.current.display_name, "-", ""))}kv"
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
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "recover",
    "restore",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey",
  ]

  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set",
  ]
}

resource "azurerm_key_vault_access_policy" "developers_group_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.developers_group.id

  key_permissions = [
    "encrypt",
  ]

  secret_permissions = [
    "list",
    "set",
  ]
}

resource "azurerm_key_vault_access_policy" "ops_group_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.operations_group.id

  key_permissions = [
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
  ]

  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set",
  ]
}

resource "azurerm_key_vault_access_policy" "platform_operations" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.platform_group.id

  key_permissions = [
    "create",
    "delete",
    "encrypt",
    "decrypt",
    "get",
    "import",
    "list",
    "recover",
    "restore",
    "update",
    "backup",
  ]

  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "recover",
    "restore",
    "set",
  ]

  certificate_permissions = [
    "backup",
    "create",
    "delete",
    "deleteissuers",
    "get",
    "getissuers",
    "import",
    "list",
    "listissuers",
    "managecontacts",
    "manageissuers",
    "recover",
    "restore",
    "setissuers",
    "update"
  ]
}

