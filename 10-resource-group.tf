#--------------------------------------------------------------
# Genesis - Resource Group
#--------------------------------------------------------------

resource "azurerm_resource_group" "genesis_resource_group" {
  location = var.location

  name = "genesis-rg"

  tags = var.tags
}

resource "random_id" "random_id" {
  keepers = {
    subscription_id = element(split("/", data.azurerm_subscription.current.id), 1)
  }

  byte_length = 6
}
