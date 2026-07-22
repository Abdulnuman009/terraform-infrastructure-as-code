data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "rds_sg" {
  name        = "terraform-rds-sg"
  description = "Allow MySQL access from anywhere"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow MySQL access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

resource "aws_db_instance" "mydb" {
  identifier = "terraform-mysql-database"

  allocated_storage = 20
  storage_type      = "gp3"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  db_name  = "mydatabase"
  username = "admin"
  password = var.db_instance_password

  parameter_group_name = "default.mysql8.0"

  db_subnet_group_name = "default"

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  publicly_accessible = true
  skip_final_snapshot = true

  tags = {
    Name = "MyDatabase"
  }
}

resource "null_resource" "local-execution" {
    depends_on = [ aws_db_instance.mydb ]

    provisioner "local-exec" {
        command = "mysql -h ${aws_db_instance.mydb.address} -P ${aws_db_instance.mydb.port} -u ${aws_db_instance.mydb.username} -p${var.db_instance_password} < init.sql"
    }

    triggers = {
      script_hash = filemd5("init.sql")
    }
}