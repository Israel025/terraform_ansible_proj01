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

pubSG_name    = "pubSG_allow_rules"
cidr_anywhere = "0.0.0.0/0"
pubSG-tags = {
  "Name" = "pubSG_rules"
}

inst-sg_ingress_rules = {
  "ingrs_rule1" = {
    description = "Allow HTTPs from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  "ingrs_rule2" = {
    description = "Allow HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  "ingrs_rule3" = {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  "ingrs_rule4" = {
    description = "Allow ICMP from anywhere"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

inst-sg_egress_rules = {
  "egrs_rule1" = {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

nacl1_ingress_rules = {
  "ingrs_rule1" = {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

nacl1_egress_rules = {
  "egrs_rule1" = {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

nacl1-tags = {
  "Name" = "nacl1_rules"
}