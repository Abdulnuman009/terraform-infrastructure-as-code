data "aws_vpc" "imported_vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc-A"]
  }
}

data "aws_availability_zones" "available" {
    filter {
        name   = "state"
        values = ["available"]
    }
}

resource "aws_subnet" "imported_subnet" {
  vpc_id            = data.aws_vpc.imported_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = var.subnet_name
  }
}