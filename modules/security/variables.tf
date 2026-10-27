
variable "project_name" {
  description = "Name used to identify project resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}



variable "ssh_allowed_cidr" {
  description = "Public IPv4 CIDR allowed to connect over SSH"
  type        = string
}