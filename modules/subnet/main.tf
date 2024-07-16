resource "aws_subnet" "public_subnet" {
 vpc_id     = var.vpc_id
 cidr_block = element(var.public_subnet_cidrs,1)
  availability_zone = element(var.azs, 1)
 
 tags = {
   Name = "Public Subnet"
 }
}
 
resource "aws_subnet" "private_subnet" {
 vpc_id     = var.vpc_id
 cidr_block = element(var.private_subnet_cidrs, 1)
  availability_zone = element(var.azs, 1)
 
 tags = {
   Name = "Private Subnet"
 }
}

resource "aws_route_table_association" "public_subnet_asso" {
 subnet_id      = aws_subnet.public_subnet.id
 route_table_id = var.public_rt_id
}

output "public_subnet_id" {
  value =aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value =aws_subnet.private_subnet.id
}