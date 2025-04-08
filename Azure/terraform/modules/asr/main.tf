
resource "azurerm_site_recovery_vault" "main" {
  name                = "techdiversa-recovery-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}
