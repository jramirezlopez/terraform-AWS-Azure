
output "resource_group_name" {
  value = module.rg.name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "firewall_public_ip" {
  value = module.firewall.firewall_ip
}

output "key_vault_uri" {
  value = module.keyvault.vault_uri
}

output "log_analytics_workspace_id" {
  value = module.sentinel.workspace_id
}

output "backup_vault_id" {
  value = module.backup.id
}

output "ddos_plan_id" {
  value = module.ddos.id
}
