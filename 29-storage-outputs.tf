data "null_data_source" "storage_outputs" {
  inputs = {
    genesis_resource_group         = "${azurerm_resource_group.genesis_resource_group.name}"
    terraform_storage_account_id   = "${azurerm_storage_account.terraform_storage_account.id}"
    terraform_storage_container_id = "${azurerm_storage_container.terraform_storage_container.id}"
    docker_storage_account_id      = "${azurerm_storage_account.docker_storage_account.id}"
  }
}

output "storage_result" {
  value = "${data.null_data_source.storage_outputs.inputs}"
}

output "storage_result_json" {
  value = "${jsonencode(data.null_data_source.storage_outputs.inputs)}"
}
