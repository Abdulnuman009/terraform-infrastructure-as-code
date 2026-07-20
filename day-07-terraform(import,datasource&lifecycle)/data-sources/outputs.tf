output "aws_vpc_id" {
  value = data.aws_vpc.imported_vpc.id
}

output "aws_subnet_id" {
  value = aws_subnet.imported_subnet.id
}

output "aws_availability_zone" {
  value = data.aws_availability_zones.available.names[0]
}