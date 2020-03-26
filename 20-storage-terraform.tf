#--------------------------------------------------------------
# Genesis - Terraform Storage Account
#--------------------------------------------------------------

resource "azurerm_storage_account" "terraform_storage_account" {
  name                     = "${lower(random_id.random_id.hex)}terraform"
  resource_group_name      = azurerm_resource_group.genesis_resource_group.name
  location                 = var.location
  account_tier             = element(split("_", var.storage_account_type), 0)
  account_replication_type = element(split("_", var.storage_account_type), 1)
  enable_blob_encryption   = "true"
  enable_file_encryption   = "true"

  tags = merge(
    map(
      "Name", format("terrform_storage_account")
    )
  )

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "terraform_storage_container" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.terraform_storage_account.name
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}
