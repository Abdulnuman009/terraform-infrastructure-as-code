# Count Example

# locals {
#   sg_names = ["dev", "test", "prod"]
# }

# resource "aws_security_group" "count-sg" {
#     vpc_id = aws_vpc.main_vpc.id

#     count = length(local.sg_names)
#     name = "${local.sg_names[count.index]}"
  
#     ingress {
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#         description = "Allow HTTP"
#     }

#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#         description = "Allow all outbound traffic"
#     }
# }

locals {
  sg_names = toset(["dev", "test", "prod"])
}

resource "aws_security_group" "count-sg" {
    vpc_id = aws_vpc.main_vpc.id

    for_each = local.sg_names
    name = each.value
  
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