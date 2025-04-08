
resource "azurerm_security_center_contact" "example" {
  name                = "example"
  email               = "security@techdiversa.com"
  phone               = "+1-222-2222222"
  alert_notifications = true
  alerts_to_admins    = true
}
