resource "aws_vpc" "imported_vpc" {
  cidr_block = "10.0.0.0/16"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "vpc-A"
  }
}

resource "aws_instance" "imported_instance" {
    ami           = "ami-0b6d9d3d33ba97d99"
    instance_type = "t3.micro"
    tags = {
        Name = "instance-A"
    }

    lifecycle {
        ignore_changes = [tags ]
        create_before_destroy = true
    }
}