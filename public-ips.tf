resource "azurerm_public_ip" "public-lb" {
  for_each = toset(var.public_ip_names)

  name                = each.value
  resource_group_name = azurerm_resource_group.genesis_resource_group
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
