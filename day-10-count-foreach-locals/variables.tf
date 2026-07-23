variable "vpc_cidr" {
  description = "CIDR range used by the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ports" {
  description = "Ports of security group inbound rules"
  type = list(number)
  default = [ 22, 80, 443, 3000, 8000 ]
}