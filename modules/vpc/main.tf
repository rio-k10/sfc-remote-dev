resource "aws_vpc" "c9" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "Cloud9 VPC"
 }
}

resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.c9.id
 
 tags = {
   Name = "Cloud9 VPC IG"
 }
}

resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.c9.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
 
 tags = {
   Name = "Public route table"
 }
}

output "vpc_id" {
    value = aws_vpc.c9.id
    description = "VPC ID"
}

output "public_rt_id" {
    value = aws_route_table.public_rt.id
    description = "Public route table ID"
}
