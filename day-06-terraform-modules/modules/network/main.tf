terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "vpc-A" {
    cidr_block = var.vpc_cidr
    region     = var.aws_region
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "subnet-A" {
    vpc_id            = aws_vpc.vpc-A.id
    cidr_block        = var.subnet_cidr
    region           = var.aws_region
    availability_zone = var.availability_zone
    tags = {
        Name = var.subnet_name
    }
}