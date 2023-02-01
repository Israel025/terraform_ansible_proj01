vpc_cidr        = "10.0.0.0/24"
tenancy_type    = "default"
vpc_name-tag1   = "Terraform-VPC"
igw_name-tag1   = "Terraform-IGW"
local-file_path = "../ansible_config/host-inventory"
subnet_values = {
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

pub-route_values = {
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
  "Name" = "Public Server-SG"
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

app-lb_values = {
  "appLB_values" = {
    name        = "tf-appLB"
    internal    = false
    lb_type     = "application"
    sec_grps    = [] #[aws_security_group.lb_sg.id]
    subnets     = [] #[for subs in aws_subnet.terraform-vpc_subnets : subs.id]
    del_protect = true
    tags = {
      Environment = "testing"
    }
  }
}

lb_SG_values = {
  "SG1_values" = {
    name = "appLB_SG"
    tags = {
      Name = "Load Balancer-SG"
    }
  }
}


LB1-sg_ingress_rules = {
  "ingrs_rule1" = {
    description = "Allow HTTPs from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  "ingrs_rule2" = {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

LB1-sg_egress_rules = {
  "egrs_rule1" = {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

appLB_TG_values = {
  "TG1-values" = {
    vpc_id           = ""
    name             = "appLB-tg"
    port             = 80
    protocol         = "HTTP"
    target_type      = "instance"
    healthy_thresh   = 3
    interval         = 20
    path             = "/"
    timeout          = 5
    unhealthy_thresh = 3
    matcher          = "200"
  }
}

LB-listens_values = {
  "listener1-values" = {
    port     = "80"
    protocol = "HTTP"
    type     = "forward"
  }
}

LB-listener_rules = {
  "listener1-rules_values" = {
    priority       = 1
    type           = "forward"
    pattern_values = ["/"]
  }
}

web_servers_values = {
  "instance1_values" = {
    ami        = "ami-00874d747dde814fa"
    inst_type  = "t2.micro"
    av_zone    = ""
    key_name   = "holidayKey"
    sec_groups = []
    subnet_id  = ""

    tags = {
      Name         = ""
      Launched-via = "Terraform"
    }
  }
}

LB-TG_attach_port = 80