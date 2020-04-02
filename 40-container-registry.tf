#--------------------------------------------------------------
# Genesis - Docker Container Registry
#--------------------------------------------------------------

resource "azurerm_container_registry" "infrastructure_container_registry_private" {
  name                = var.acr_private_repo
  resource_group_name = azurerm_resource_group.genesis_resource_group.name
  location            = var.location
  admin_enabled       = "true"
  sku                 = "Standard"
}

resource "azurerm_container_registry" "infrastructure_container_registry_public" {
  name                = var.acr_public_repo
  resource_group_name = azurerm_resource_group.genesis_resource_group.name
  location            = var.location
  admin_enabled       = "true"
  sku                 = "Standard"
}
