data "aws_vpc" "default" {
  default = true
}

data "aws_db_instance" "mydb" {
  db_instance_identifier = "terraform-06abdf8f442ca6df12dd5471dc"
}

resource "aws_key_pair" "sql_runner_key" {
  key_name   = "sql-runner-key"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}

resource "aws_security_group" "sql_runner_sg" {
  name        = "sql-runner-sg"
  description = "Allow SSH to SQL runner EC2"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from my laptop"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sql-runner-sg"
  }
}

resource "aws_instance" "sql_runner" {
  ami                         = "ami-0b6d9d3d33ba97d99"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.sql_runner_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sql_runner_sg.id]

  tags = {
    Name = "SQL Runner"
  }
}

resource "null_resource" "remote_database_initialization" {
  depends_on = [
    aws_instance.sql_runner
  ]

  triggers = {
    script_hash = filemd5("${path.module}/init.sql")
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.sql_runner.public_ip
    private_key = file(pathexpand("~/.ssh/id_ed25519"))
    timeout     = "5m"
  }

  provisioner "file" {
    source      = "${path.module}/init.sql"
    destination = "/home/ubuntu/init.sql"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",

      # Only install the client—the server is RDS
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y default-mysql-client",

      # Execute init.sql against the existing database
      "mysql --host='${data.aws_db_instance.mydb.address}' --port='${data.aws_db_instance.mydb.port}' --user='${var.db_instance_username}' --password='${var.db_instance_password}' '${data.aws_db_instance.mydb.db_name}' < /home/ubuntu/init.sql"
    ]
  }
}