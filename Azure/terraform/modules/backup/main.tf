
resource "azurerm_recovery_services_vault" "main" {
  name                = "techdiversa-backup-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  soft_delete_enabled = true
}
