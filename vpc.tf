#============================================
# aws provider connection details configuration
provider "aws" {
  region     = var.aws_vpc_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
#============================================

#============================================
#create a new aws vpc
resource "aws_vpc" "terraform_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy_type

  tags = {
    Name = var.vpc_name-tag1
  }
}

# create and attach an igw for the newly created vpc
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = var.igw_name-tag1
  }

  depends_on = [
    aws_vpc.terraform_vpc
  ]
}

# create preffered amount of subnets in the vpc (3 subnets in different availability zones)
resource "aws_subnet" "terraform-vpc_subnets" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  for_each                = var.subnet_vals
  #map_public_ip_on_launch = each.value["add_public-ip"]
  cidr_block              = each.value["subnet_cidr"]
  availability_zone       = each.value["av_zone"]
  tags                    = each.value["tags"]

  depends_on = [
    aws_vpc.terraform_vpc
  ]
}

# setup a route table for the created subnets
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = var.pub-route_vals["rule-1"]["public-route_cidr"]
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = var.pub-route_vals["rule-1"]["tags"]

  depends_on = [
    aws_vpc.terraform_vpc,
    aws_internet_gateway.vpc-igw
  ]
}

output "subnet_ids" {
  value       = aws_subnet.terraform-vpc_subnets[each.key].id
  description = "The IDs for all created subnets"
}

# output "subnet_ids" {
#   value = []
# }

# associate the route table to the subnets created
# resource "aws_route_table_association" "subnets_route" {
#   subnet_id      = aws_subnet.terraform-vpc_subnets[each.key]
#   route_table_id = aws_route_table.public_route.id
# }
