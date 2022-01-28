resource "azurerm_public_ip" "this" {
  for_each = toset(var.public_ip_names)

  name                = var.project != "" ? "${var.project}-${each.value}-${var.environment}-pip" : "${each.value}-${var.environment}-pip"
  resource_group_name = azurerm_resource_group.genesis_resource_group.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
