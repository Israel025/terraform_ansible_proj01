#==========================================
# create preffered amount of subnets in the vpc (3 subnets in different availability zones)
resource "aws_subnet" "terraform-vpc_subnets" {
  vpc_id   = aws_vpc.terraform_vpc.id
  for_each = var.subnet_vals
  #map_public_ip_on_launch = each.value["add_public-ip"]
  cidr_block        = each.value["subnet_cidr"]
  availability_zone = each.value["av_zone"]
  tags              = each.value["tags"]
}