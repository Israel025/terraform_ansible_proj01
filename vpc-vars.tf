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