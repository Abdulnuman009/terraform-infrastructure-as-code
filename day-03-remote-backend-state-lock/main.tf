resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = var.subnet_name
  }
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_1.id
  tags = {
    Name = var.instance_name
  }
}