module "networking" {
  source = "./modules/networking"

  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
  aws_region   = var.aws_region
}

module "compute" {
  source = "./modules/compute"

  instance_count  = var.instance_count
  vpc_id          = module.networking.vpc_id
  subnet_id       = module.networking.public_subnet_id
  environment     = var.environment
  alb_sg_id       = module.networking.alb_sg_id
}

module "database" {
  source = "./modules/database"

  vpc_id         = module.networking.vpc_id
  subnet_ids     = [module.networking.private_subnet_id]
  db_credentials = var.db_credentials
  environment    = var.environment
  ec2_sg_id      = module.compute.ec2_sg_id
}

module "cache" {
  source = "./modules/cache"

  vpc_id         = module.networking.vpc_id
  subnet_ids     = [module.networking.private_subnet_id]
  redis_config   = var.redis_config
  environment    = var.environment
  ec2_sg_id      = module.compute.ec2_sg_id
}

module "dns" {
  source = "./modules/dns"

  domain_name    = var.domain_name
  alb_dns_name   = module.compute.alb_dns_name
  alb_zone_id    = module.compute.alb_zone_id
  environment    = var.environment
}