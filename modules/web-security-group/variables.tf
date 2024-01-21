variable "vpc_id" {
    description = "VPC Id"
    type = string
    default = ""
}

variable "name" {
    description = "Name of security group"
    type = string
    default = "Terraform security group"
}
