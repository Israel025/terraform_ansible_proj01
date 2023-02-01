variable "aws_access_key" {
  description = "AWS access key variable definition"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key variable definition"
  type        = string
}

variable "aws_vpc_region" {
  description = "AWS preferred vpc region variable"
  type        = string
}

variable "vpc_cidr" {
  description = "preferred cidr for the created vpc"
  type        = string
}

variable "tenancy_type" {
  description = "declaring the tenancy type for the vpc"
  type        = string
}

variable "vpc_name-tag1" {
  description = "variable for the name tag for the created vpc"
  type        = string
}

variable "igw_name-tag1" {
  description = "Internet gateway name tage variable"
  type        = string
}

variable "subnet_values" {
  description = "This variable holds the values to be populated for the vpc subnets"
  type = map(object({
    av_zone       = string
    subnet_cidr   = string
    add_public-ip = bool
    tags          = map(string)
  }))
}

variable "pub-route_values" {
  description = "holds the values for creating the aws route table resource"
  type = map(object({
    public-route_cidr = string
    tags              = map(string)
  }))
}

variable "pubSG_name" {
  description = "holds the preferred name for the public security group"
  type        = string
}

variable "pubSG-tags" {
  description = "holds the preferred tags for the public security group"
  type        = map(string)
}

variable "cidr_anywhere" {
  description = "holds the 'anywhere' cidr value "
  type        = string
}

variable "inst-sg_ingress_rules" {
  description = "variable for instances security group ingress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "inst-sg_egress_rules" {
  description = "variable for instances security group egress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "nacl1_ingress_rules" {
  description = "variable for network access control list ingress rules"
  type = map(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl1_egress_rules" {
  description = "variable for network access control list egress rules"
  type = map(object({
    protocol   = string
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl1-tags" {
  description = "variable for network access control list tags"
  type        = map(string)
}

variable "app-lb_values" {
  description = "Variable definiations for the Application load balancer resource"
  type = map(object({
    name        = string
    internal    = bool
    lb_type     = string
    sec_grps    = list(string)
    subnets     = list(string)
    del_protect = bool
    tags        = map(string)
  }))
}

variable "lb_SG_values" {
  description = "Holds the preferred name for the load balancer security group"
  type = map(object({
    name = string
    tags = map(string)
  }))
}


variable "LB1-sg_ingress_rules" {
  description = "variable for application load balancer security group ingress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "LB1-sg_egress_rules" {
  description = "variable for application load balancer security group egress rules"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "appLB_TG_values" {
  description = "holds the values for creating the aws load balancer target group"
  type = map(object({
    name             = string
    port             = number
    protocol         = string
    vpc_id           = string
    target_type      = string
    healthy_thresh   = number
    interval         = number
    path             = string
    timeout          = number
    unhealthy_thresh = number
    matcher          = string
  }))
}

variable "LB-listens_values" {
  description = "holds the values for creating the aws load balancer listener resource"
  type = map(object({
    port     = string
    protocol = string
    type     = string
  }))
}

variable "LB-listener_rules" {
  description = "holds the values for creating the aws load balancer listener rules resource"
  type = map(object({
    priority       = number
    type           = string
    pattern_values = list(string)
  }))
}

variable "web_servers_values" {
  description = "holds the values for setting-up ec2 instance resources"
  type = map(object({
    ami        = string
    inst_type  = string
    av_zone    = string
    key_name   = string
    sec_groups = list(string)
    subnet_id  = string
    tags       = map(string)
  }))
}

variable "LB-TG_attach_port" {
  description = "Defines the port for the load balancing attachment resource"
  type        = number
}

variable "local-file_path" {
  description = "States where the ansible inventory file should be created"
  type        = string
}

variable "route53_zone_values" {
  description = "holds the values for route53 hosted zone resource"
  type = map(object({
    domain_name = string
    tags        = map(string)
  }))
}

variable "route53-A_record_values" {
  description = "holds the values for route53 alias (A) record resource"
  type = map(object({
    record_type  = string
    check_health = bool
  }))
}