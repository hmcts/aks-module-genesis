data "null_data_source" "key_vault_outputs" {
  inputs = {
    azurerm_key_vault_id = azurerm_key_vault.key_vault.id
  }
}

output "key_vault_result" {
  value = data.null_data_source.key_vault_outputs.inputs
}

output "key_vault_result_json" {
  value = jsonencode(data.null_data_source.key_vault_outputs.inputs)
}
