variable "db_instance_username" {
  description = "The master username for the database instance"
  type        = string
  default     = "admin"
}

variable "db_instance_password" {
  description = "The password for the database instance"
  type        = string
  sensitive   = true
}