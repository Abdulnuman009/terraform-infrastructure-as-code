resource "aws_vpc" "mainVpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "mainSubnet" {
  vpc_id            = aws_vpc.mainVpc.id
  map_public_ip_on_launch = true
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "main-subnet"
  }
}

resource "aws_internet_gateway" "mainIgw" {
  vpc_id = aws_vpc.mainVpc.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "mainRt" {
  vpc_id = aws_vpc.mainVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mainIgw.id
  }
  tags = {
    Name = "main-rt"
  }
}

resource "aws_route_table_association" "mainRta" {
  subnet_id      = aws_subnet.mainSubnet.id
  route_table_id = aws_route_table.mainRt.id
}

resource "aws_security_group" "mainSg" {
  name        = "main-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.mainVpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}   

resource "aws_key_pair" "mainKeyPair" {
  key_name   = "main-key-pair"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}

resource "aws_instance" "mainInstance" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mainSubnet.id
  vpc_security_group_ids = [aws_security_group.mainSg.id]
  key_name        = aws_key_pair.mainKeyPair.key_name

  tags = {
    Name = "main-instance"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(pathexpand("~/.ssh/id_ed25519"))
    host        = self.public_ip
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "${path.module}/setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/setup.sh",
      "sudo /home/ubuntu/setup.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo 'Instance ${self.id} has been created with public IP ${self.public_ip}'"
  }
}
