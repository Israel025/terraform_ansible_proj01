#============================================
# aws provider connection details configuration
provider "aws" {
  region     = var.aws_vpc_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
#============================================


#============================================
#Run the ansible script via terraform
provisioner "local-exec" {
  command = "ansible-playbook -i host-inventory ansible-tf_play.yml"
}