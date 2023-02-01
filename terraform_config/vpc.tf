#============================================
#create a new aws vpc
resource "aws_vpc" "terraform_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy_type

  tags = {
    Name = var.vpc_name-tag1
  }
}

#===============================================
# create and attach an igw for the newly created vpc
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = var.igw_name-tag1
  }
}

#==========================================
# create preffered amount of subnets in the vpc (3 subnets in different availability zones)
resource "aws_subnet" "terraform-vpc_subnets" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  for_each                = var.subnet_values
  map_public_ip_on_launch = each.value["add_public-ip"]
  cidr_block              = each.value["subnet_cidr"]
  availability_zone       = each.value["av_zone"]
  tags                    = each.value["tags"]
}