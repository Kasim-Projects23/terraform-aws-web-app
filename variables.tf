
variable "project_name" {
  description = "Name used to identify project resources"
  type        = string
}



variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
}



variable "subnet_cidr" {
  description = "CIDR range for the public subnet"
  type        = string
}



variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  type        = string
}



variable "ssh_allowed_cidr" {
  description = "Public IPv4 CIDR allowed to connect over SSH"
  type        = string
}



variable "instance_type" {
  description = "EC2 instance type for the web server"
  type        = string
  default     = "t3.micro"
}



variable "key_name" {
  description = "Name of the existing EC2 key pair for SSH access"
  type        = string
}
