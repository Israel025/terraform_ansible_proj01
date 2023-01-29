#===============================================
# create and attach an igw for the newly created vpc
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = var.igw_name-tag1
  }
}