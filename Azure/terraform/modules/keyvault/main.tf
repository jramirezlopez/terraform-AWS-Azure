
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                        = "techdiversa-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
}
