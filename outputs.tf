
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



output "web_server_instance_id" {
  description = "ID of the EC2 web server"
  value       = module.web_server.instance_id
}



output "web_server_public_ip" {
  description = "Public IPv4 address of the web server"
  value       = module.web_server.public_ip
}



output "web_server_public_dns" {
  description = "Public DNS name of the web server"
  value       = module.web_server.public_dns
}
