
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
