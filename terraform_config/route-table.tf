#=================================
# setup a route table for the created subnets
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = var.pub-route_values["rule-1"]["public-route_cidr"]
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = var.pub-route_values["rule-1"]["tags"]
}

# associate the route table to the subnets created
resource "aws_route_table_association" "subnets_route" {
  for_each       = aws_subnet.terraform-vpc_subnets
  subnet_id      = each.value["id"]
  route_table_id = aws_route_table.public_route.id
}