
module "networking" {
  source = "./modules/networking"

  project_name      = var.project_name
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
}



module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.networking.vpc_id

  ssh_allowed_cidr = var.ssh_allowed_cidr
}



module "web_server" {
  source = "./modules/web-server"

  project_name      = var.project_name
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.security.security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
}
