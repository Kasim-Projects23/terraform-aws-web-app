
output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.networking.vpc_id
}



output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.networking.public_subnet_id
}



output "security_group_id" {
  description = "ID of the web application security group"
  value       = module.security.security_group_id
}
