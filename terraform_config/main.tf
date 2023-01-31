#============================================
# aws provider connection details configuration
provider "aws" {
  region     = var.aws_vpc_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
#============================================

# output "sub_len" {
#   value = [for subs in aws_subnet.terraform-vpc_subnets : subs.id]
# }