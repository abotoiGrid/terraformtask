provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
  tags     = var.tags
}

module "compute" {
  source            = "./modules/ec2"
  base_ami          = var.base_ami
  ami_name          = var.ami_name
  instance_type     = var.instance_type
  user_data         = var.user_data
  security_group_id = module.networking.security_group_id
  subnet_ids        = module.networking.subnet_ids
  instances         = var.instances
  tags              = var.tags
}

module "loadbalancer" {
  source            = "./modules/loadbalancer"
  lb_name           = var.lb_name
  tg_name           = var.tg_name
  security_group_id = module.networking.security_group_id
  subnet_ids        = module.networking.subnet_ids
  vpc_id            = module.networking.vpc_id
  instance_ids      = module.compute.instance_ids
  tags              = var.tags
}