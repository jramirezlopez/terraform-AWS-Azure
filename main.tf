terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {}
}

# ======================
# Variables Globales
# ======================
variable "location" {
  default = "East US"
}

# ======================
# Resource Group
# ======================
module "rg" {
  source   = "./modules/rg"
  location = var.location
}

# ======================
# Network (VNet + Subnet)
# ======================
module "network" {
  source              = "./modules/network"
  location            = var.location
  resource_group_name = module.rg.main.name
}

# ======================
# Key Vault
# ======================
module "keyvault" {
  source              = "./modules/keyvault"
  location            = var.location
  resource_group_name = module.rg.main.name
}

# ======================
# Azure Identity (User-assigned)
# ======================
module "identity" {
  source              = "./modules/identity"
  location            = var.location
  resource_group_name = module.rg.main.name
}

# ======================
# Microsoft Defender (Azure Security Center)
# ======================
module "security" {
  source              = "./modules/security"
}

# ======================
# Azure Backup Vault
# ======================
module "backup" {
  source              = "./modules/backup"
  location            = var.location
  resource_group_name = module.rg.main.name
}

# ======================
# Azure Site Recovery
# ======================
module "asr" {
  source              = "./modules/asr"
  location            = var.location
  resource_group_name = module.rg.main.name
}

# ======================
# Azure Firewall
# ======================
module "firewall" {
  source              = "./modules/firewall"
  location            = var.location
  resource_group_name = module.rg.main.name
  firewall_subnet_id  = module.network.public_subnet_id  # Asumimos que tienes este output en network
}

# ======================
# Microsoft Sentinel
# ======================
module "sentinel" {
  source              = "./modules/sentinel"
  location            = var.location
  resource_group_name = module.rg.main.name
}

# ======================
# Azure Policy
# ======================
module "policy" {
  source = "./modules/policy"
  scope  = module.rg.main.id
}

# ======================
# Azure DDoS Protection Plan
# ======================
module "ddos" {
  source              = "./modules/ddos"
  location            = var.location
  resource_group_
