#=====================================
# Create aws ec2 application servers
resource "aws_instance" "web_servers" {
  for_each          = aws_subnet.terraform-vpc_subnets
  ami               = var.web_servers_values["instance1_values"]["ami"]
  instance_type     = var.web_servers_values["instance1_values"]["inst_type"]
  availability_zone = each.value["availability_zone"]
  key_name          = var.web_servers_values["instance1_values"]["key_name"]
  security_groups   = [aws_security_group.public-subnets_SG.id]
  subnet_id         = each.value["id"]

  tags = {
    Name         = "webserver_${each.value["tags"]["name"]}"
    Launched-via = var.web_servers_values["instance1_values"]["tags"]["Launched-via"]
  }

  depends_on = [
    aws_internet_gateway.vpc-igw
  ]
}