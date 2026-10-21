
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
