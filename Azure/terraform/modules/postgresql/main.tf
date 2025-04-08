resource "azurerm_postgresql_flexible_server" "db" {
  name                          = "techdiversa-db"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  administrator_login           = var.admin_user
  administrator_password        = var.admin_password
  version                       = "13"
  sku_name                      = "GP_Standard_D2s_v3"
  storage_mb                    = 32768
  public_network_access_enabled = false

  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = var.private_dns_zone_id
  zone                = "1"
}

