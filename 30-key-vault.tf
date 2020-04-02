#--------------------------------------------------------------
# Genesis - Infrastructure Key Vault
#--------------------------------------------------------------

resource "azurerm_key_vault" "key_vault" {
  name                = var.devops_key_vault
  resource_group_name = azurerm_resource_group.genesis_resource_group.name
  location            = var.location

  sku_name = "standard"

  tenant_id = data.azurerm_client_config.current.tenant_id

  enabled_for_deployment          = "true"
  enabled_for_disk_encryption     = "true"
  enabled_for_template_deployment = "true"

  tags = merge(
    map(
      "Name", format("devops_key_vault")
    )
  )
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.service_principal_object_id

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
