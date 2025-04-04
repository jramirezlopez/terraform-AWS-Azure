
# Salida con el DNS del Load Balancer y la IP pública de la instancia

output "alb_dns" {
  value = module.alb.alb_dns
}
