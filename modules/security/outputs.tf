
output "security_group_id" {
  description = "ID of the web application security group"
  value       = aws_security_group.web.id
}
