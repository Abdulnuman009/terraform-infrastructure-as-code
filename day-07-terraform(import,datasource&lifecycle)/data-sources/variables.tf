variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet_name" {
  description = "The name tag for the subnet"
  type        = string
  default     = "imported-subnet"
}