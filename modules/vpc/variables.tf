variable "cidr_block" {
    description = "CIDR block for VPC"
    type = string
    default = ""
}

variable "tags" {
    description = "Tags for EC2 instance"
    type = map(string)
    default = {}
  
}