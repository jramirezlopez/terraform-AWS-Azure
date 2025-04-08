
resource "azurerm_network_ddos_protection_plan" "main" {
  name                = "techdiversa-ddos"
  location            = var.location
  resource_group_name = var.resource_group_name
}
