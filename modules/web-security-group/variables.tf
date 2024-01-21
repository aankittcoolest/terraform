variable "vpc_id" {
    description = "VPC Id"
    type = string
    default = ""
}

variable "cidr_blocks" {
    description = "Cidr blocks"
    type = list(string)
    default = []
}

variable "name" {
    description = "Name of security group"
    type = string
    default = ""
}