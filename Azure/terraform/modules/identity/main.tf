
resource "azurerm_user_assigned_identity" "main" {
  name                = "techdiversa-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}
