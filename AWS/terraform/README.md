
# Infraestructura Segura - TechDiversa

Este proyecto despliega infraestructura básica en AWS con:
- Auto Scaling Group (ASG)
- Application Load Balancer (ALB)
- Encriptación en reposo en EC2 (volumen EBS)
- Script de inicialización con Apache (user_data.sh)

## Características

- ALB distribuye tráfico entre múltiples instancias EC2 gestionadas por un ASG.
- Las instancias usan un Launch Template con volúmenes EBS cifrados.
- Incluye configuraciones de red, subredes públicas y routing.
- Código modular y reutilizable.

## Seguridad

**Importante**: Este proyecto **no incluye AWS WAF** por defecto, ya que **no forma parte de la capa gratuita** de AWS.  
Sin embargo, **se recomienda fuertemente** agregar un Web Application Firewall (WAF) para proteger la capa 7 de ataques comunes y limitar el acceso según reglas personalizadas.

Más info: [https://aws.amazon.com/waf/pricing](https://aws.amazon.com/waf/pricing)

## Instrucciones

```bash
terraform init
terraform apply
```

## Requisitos

- Cuenta AWS con permisos suficientes
- Terraform >= 1.0
