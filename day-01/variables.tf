variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "vpc_name_1" {
  description = "The name of the first VPC"
  type        = string
}

variable "vpc_name_2" {
  description = "The name of the second VPC"
  type        = string
}

variable "cidr_block_1" {
  description = "The CIDR block for the first VPC"
  type        = string
}

variable "cidr_block_2" {
  description = "The CIDR block for the second VPC"
  type        = string
}

variable "subnet_name_1" {
  description = "The name of the first subnet"
  type        = string
}

variable "subnet_name_2" {
  description = "The name of the second subnet"
  type        = string
}

variable "subnet_cidr_block_1" {
  description = "The CIDR block for the first subnet"
  type        = string
}

variable "subnet_cidr_block_2" {
  description = "The CIDR block for the second subnet"
  type        = string
}

variable "subnet_1_az" {
  description = "The availability zone for the first subnet"
  type        = string
}

variable "subnet_2_az" {
  description = "The availability zone for the second subnet"
  type        = string
}