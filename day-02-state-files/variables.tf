variable "ami_id" {
    description = "The AMI ID to use for the EC2 instance"
    type        = string
}

variable "instance_type" {
    description = "The instance type for the EC2 instance"
    type        = string
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "subnet_cidr" {
    description = "The CIDR block for the subnet"
    type        = string
}

variable "region" {
    description = "The AWS region to deploy resources"
    type        = string
}

variable "vpc_name" {
    description = "The name tag for the VPC"
    type        = string
}

variable "subnet_name" {
    description = "The name tag for the subnet"
    type        = string
}

variable "ec2_name" {
    description = "The name tag for the EC2 instance"
    type        = string
}