resource "aws_vpc" "first_vpc" {
    cidr_block = var.vpc_cidr
    region     = var.region
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "first_subnet" {
    vpc_id            = aws_vpc.first_vpc.id
    cidr_block        = var.subnet_cidr
    tags = {
        Name = var.subnet_name
    }
}

resource "aws_instance" "first_ec2" {
    ami           = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = var.ec2_name
    }
    subnet_id = aws_subnet.first_subnet.id
}

resource "aws_instance" "second_ec2" {
    ami           = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "${var.ec2_name}_second"
    }
    subnet_id = aws_subnet.first_subnet.id
}