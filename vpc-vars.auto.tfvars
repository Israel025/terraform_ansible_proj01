vpc_cidr      = "10.0.0.0/24"
tenancy_type  = "default"
vpc_name-tag1 = "Terraform-VPC"
igw_name-tag1 = "Terraform-IGW"
subnet_vals = {
  "subnet-A" = {
    av_zone       = "us-east-1a"
    subnet_cidr   = "10.0.0.0/26"
    add_public-ip = true
    tags = {
      "name" = "Subnet-A"
    }
  }
  "subnet-B" = {
    av_zone       = "us-east-1b"
    subnet_cidr   = "10.0.0.64/26"
    add_public-ip = true
    tags = {
      "name" = "Subnet-B"
    }
  }
  "subnet-C" = {
    av_zone       = "us-east-1c"
    subnet_cidr   = "10.0.0.128/26"
    add_public-ip = true
    tags = {
      "name" = "Subnet-C"
    }
  }
}

pub-route_vals = {
  "rule-1" = {
    public-route_cidr = "0.0.0.0/0"
    tags = {
      "name" = "Public_route-table"
    }
  }
}