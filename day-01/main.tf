resource "aws_vpc" "main_1" {
  cidr_block = var.cidr_block_1
  tags = {
    Name = var.vpc_name_1
  }
}

resource "aws_vpc" "main_2" {
  cidr_block = var.cidr_block_2
  tags = {
    Name = var.vpc_name_2
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.main_1.id
  cidr_block = var.subnet_cidr_block_1
  availability_zone = var.subnet_1_az
  tags = {
    Name = var.subnet_name_1
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.main_2.id
  cidr_block = var.subnet_cidr_block_2
  availability_zone = var.subnet_2_az
  tags = {
    Name = var.subnet_name_2
  }
}