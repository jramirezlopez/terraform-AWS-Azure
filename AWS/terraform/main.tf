
# Proyecto principal de Terraform para desplegar infraestructura TechDiversa

provider "aws" {
  region = var.region
}

# Módulo de red (VPC, subredes, rutas)
module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  region   = var.region
}

# Módulo de Auto Scaling (EC2 múltiple + encriptación)
module "autoscaling" {
  source        = "./modules/autoscaling"
  ami           = var.ami
  instance_type = var.instance_type
  subnet_ids    = [module.network.public_subnet_1, module.network.public_subnet_2]
  vpc_id        = module.network.vpc_id
  user_data     = file("user_data.sh")
}

# Módulo de Load Balancer (apunta al target group del ASG)
module "alb" {
  source    = "./modules/alb"
  vpc_id    = module.network.vpc_id
  subnets   = [module.network.public_subnet_1, module.network.public_subnet_2]
  target_id = module.autoscaling.target_group_arn
  sg_id     = module.autoscaling.launch_sg_id
}

module "waf" {
  source  = "./modules/waf"
  alb_arn = module.alb.alb_arn
}

module "rds" {
  source     = "./modules/rds"
  subnet_ids = [module.network.public_subnet_1, module.network.public_subnet_2]
  db_user    = "techadmin"
  db_pass    = "TechDiversa123!"
  db_sg_id   = module.autoscaling.launch_sg_id
}

module "backup" {
  source       = "./modules/backup"
  rds_arn      = module.rds.techdiversa_db_arn # output que puedes definir
  iam_role_arn = aws_iam_role.aws_backup_role.arn
}

module "security" {
  source          = "./modules/security"
  bucket          = "techdiversa-cloudtrail-logs"
  config_role_arn = aws_iam_role.config_role.arn
}
