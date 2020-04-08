#--------------------------------------------------------------
# Genesis - Resource Group
#--------------------------------------------------------------

# Looking up Resource Group in hmcts-control

data "azurerm_resources" "hmcts_control_resource_group" {
  resource_group_name = "azure-control-sbox-rg"
}

output "value" {
  value = data.azurerm_resource_group.name
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
