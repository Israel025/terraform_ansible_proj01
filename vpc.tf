#============================================
#create a new aws vpc
resource "aws_vpc" "terraform_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy_type

  tags = {
    Name = var.vpc_name-tag1
  }
}