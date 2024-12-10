module "networking" {
  source  = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  subnets = [
    { cidr_block = "10.0.0.0/24", availability_zone = "us-east-1a" },
    { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1b" },
    { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1c" }
  ]
  tags = {
    Name    = "test90"
    Owner   = "abotoi"
    Project = "2024_internship_moldova"
  }
}

module "compute" {
  source            = "./modules/ec2_instance"
  base_ami          = "ami-0e2c8caa4b6378d8c"
  ami_name          = "ami_vm_image"
  instance_type     = "t3.micro"
  user_data         = "userdata.sh"
  security_group_id = module.networking.security_group_id
  subnet_ids        = module.networking.subnet_ids
  vpc_id            = module.networking.vpc_id
  lb_name           = "myalb"
  tg_name           = "myTG"
  instances = {
    webserver1 = { instance_type = "t3.micro", subnet_id = module.networking.subnet_ids[0], user_data = "userdata.sh" },
    webserver2 = { instance_type = "t3.micro", subnet_id = module.networking.subnet_ids[1], user_data = "userdata1.sh" },
    webserver3 = { instance_type = "t3.micro", subnet_id = module.networking.subnet_ids[2], user_data = "userdata2.sh" }
  }
  tags = {
    Name    = "test90"
    Owner   = "abotoi"
    Project = "2024_internship_moldova"
  }
}

output "load_balancer_dns" {
  value = module.compute.lb_dns_name
}
