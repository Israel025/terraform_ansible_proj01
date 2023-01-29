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
}

# create preffered amount of subnets in the vpc (3 subnets in different availability zones)
resource "aws_subnet" "terraform-vpc_subnets" {
  vpc_id   = aws_vpc.terraform_vpc.id
  for_each = var.subnet_vals
  #map_public_ip_on_launch = each.value["add_public-ip"]
  cidr_block        = each.value["subnet_cidr"]
  availability_zone = each.value["av_zone"]
  tags              = each.value["tags"]
}

# setup a route table for the created subnets
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = var.pub-route_vals["rule-1"]["public-route_cidr"]
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = var.pub-route_vals["rule-1"]["tags"]
}

# associate the route table to the subnets created
resource "aws_route_table_association" "subnets_route" {
  for_each       = aws_subnet.terraform-vpc_subnets
  subnet_id      = each.value["id"]
  route_table_id = aws_route_table.public_route.id
}

# create security group rules for the public subnets
resource "aws_security_group" "public-subnets_SG" {
  name        = var.pubSG_name
  description = "SSH, HTTP & HTTPS Alllow rules for the public subnets"
  vpc_id      = aws_vpc.terraform_vpc.id

  dynamic "ingress" {
    for_each = var.inst-sg_ingress_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_anywhere]
  }

  tags = var.pubSG-tags
}
