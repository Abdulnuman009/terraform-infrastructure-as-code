module "local" {
    source = "./modules/network"
    vpc_cidr = var.vpc_cidr
    subnet_cidr = var.subnet_cidr
    aws_region = var.aws_region
    vpc_name = var.vpc_name
    subnet_name = var.subnet_name
}

module "remote" {
    source = "./modules/network"
    aws_region = "us-west-2"
    availability_zone = "us-west-2a"
    vpc_cidr = "10.1.0.0/16"
    subnet_cidr = "10.1.1.0/24"
    vpc_name = "prod-vpc"
    subnet_name = "prod-subnet"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  region = var.aws_region
  name = "my-vpc"
  cidr = "10.10.0.0/16"

  tags = {
    Name      = "my-vpc"
  }
}