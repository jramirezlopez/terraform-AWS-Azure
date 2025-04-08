
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {}
  subscription_id = "9e23ec51-4b5a-491f-b1dc-f9ccdf72ce80"
}

module "rg" {
  source   = "./modules/rg"
  location = var.location
}

module "network" {
  source                = "./modules/network"
  location              = var.location
  resource_group_name   = module.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  vnet_id               = module.network.vnet_id
}

module "keyvault" {
  source              = "./modules/keyvault"
  location            = var.location
  resource_group_name = module.rg.name
}

module "identity" {
  source              = "./modules/identity"
  location            = var.location
  resource_group_name = module.rg.name
}

module "security" {
  source = "./modules/security"
}

module "backup" {
  source              = "./modules/backup"
  location            = var.location
  resource_group_name = module.rg.name
}

module "firewall" {
  source              = "./modules/firewall"
  location            = var.location
  resource_group_name = module.rg.name
  firewall_subnet_id  = module.network.public_subnet_id
}

module "sentinel" {
  source              = "./modules/sentinel"
  location            = var.location
  resource_group_name = module.rg.name
}

module "policy" {
  source = "./modules/policy"
  scope  = module.rg.id
}

module "ddos" {
  source              = "./modules/ddos"
  location            = var.location
  resource_group_name = module.rg.name
}

module "vm" {
  source              = "./modules/vm"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.web_subnet_id
}

resource "azurerm_private_dns_zone" "postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = module.rg.name
}

module "postgresql" {
  source              = "./modules/postgresql"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.postgresql_subnet_id
  private_dns_zone_id = azurerm_private_dns_zone.postgresql.id
  admin_user          = "dbadmin"
  admin_password      = "SuperSecurePassword123!"
}
