#--------------------------------------------------------------
# Genesis - Docker Container Registry
#--------------------------------------------------------------

resource "azurerm_container_registry" "infrastructure_container_registry" {
  name                = "petinfrastructure"
  resource_group_name = azurerm_resource_group.genesis_resource_group.name
  location            = var.location
  admin_enabled       = "true"
  sku                 = "Standard"
}
