
output "instance_id" {
  description = "ID of the EC2 web server"
  value       = aws_instance.web.id
}



output "public_ip" {
  description = "Public IPv4 address of the web server"
  value       = aws_instance.web.public_ip
}



output "public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.web.public_dns
}
