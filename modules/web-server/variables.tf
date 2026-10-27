
variable "project_name" {
  description = "Name used to identify project resources"
  type        = string
}



variable "subnet_id" {
  description = "ID of the public subnet for the web server"
  type        = string
}



variable "security_group_id" {
  description = "ID of the security group attached to the web server"
  type        = string
}



variable "instance_type" {
  description = "EC2 instance type for the web server"
  type        = string
  default     = "t3.micro"
}



variable "key_name" {
  description = "Name of the EC2 key pair used for SSH access"
  type        = string
}
