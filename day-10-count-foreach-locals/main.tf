resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "day-10-main-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "day-10-public-subnet"
  }
}

locals {
  ports = var.ports
}

resource "aws_security_group" "test-sg" {
    name = "test-sg"
    description = "Security Group"
    vpc_id = aws_vpc.main_vpc.id

    dynamic "ingress" {
      for_each = local.ports
      content {
        from_port = ingress.value
        to_port = ingress.value
        description = "Allow port ${ingress.value}"
        cidr_blocks = [ "0.0.0.0/0" ]
        protocol = "tcp"
      }
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
}