variable "vpc_id" {
    description = "VPC Id"
    type = string
    default = ""
}

variable "internet_gateway_id" {
    description = "Internet gateway Id"
    type = string
    default = ""
}

variable "tags" {
    description = "Tags for EC2 instance"
    type = map(string)
    default = {}
  
}

variable "public_subnet_cidrs" {
    description = "Public subnet cidrs"
    type = list(string)
    default = []
}

variable "public_subnets" {
    description = "Public subnets"
    type = list(string)
    default = []
}