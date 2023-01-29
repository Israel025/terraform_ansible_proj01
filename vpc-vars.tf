variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "aws_vpc_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "tenancy_type" {
  type = string
}

variable "vpc_name-tag1" {
  type = string
}

variable "igw_name-tag1" {
  type = string
}

variable "subnet_vals" {
  type = map(object({
    av_zone       = string
    subnet_cidr   = string
    add_public-ip = bool
    tags          = map(string)
  }))
}

variable "pub-route_vals" {
  type = map(object({
    public-route_cidr = string
    tags              = map(string)
  }))
}

variable "pubSG_name" {
  type = string
}

variable "pubSG-tags" {
  type = map(string)
}

variable "cidr_anywhere" {
  type = string
}

variable "inst-sg_ingress_rules" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "inst-sg_egress_rules" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "nacl1_ingress_rules" {
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
  type = map(string)
}