module "network" {
  source              = "./modules/network"
  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_az   = var.public_subnet_az
}

module "server" {
  source           = "./modules/server"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = module.network.subnet_id
  security_group_id = module.network.security_group_id
  instance_name   = "AppServer"
  key_name        = var.key_name
}
