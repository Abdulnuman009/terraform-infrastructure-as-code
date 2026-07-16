resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "main_subnet"
  }
  availability_zone = "${var.aws_region}a"
  depends_on = [aws_vpc.main]
}

resource "aws_security_group" "main" {
  name        = "main_sg"
  description = "Main security group"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "main_sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami           = "ami-01edba92f9036f76e"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.main.id]
  tags = {
    Name = "main_instance"
  }
}