variable "private_subnet_cidrs" {
  type        = list(string)
  description = "private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
  default = ""
}

variable "tags" {
    description = "Tags for EC2 instance"
    type = map(string)
    default = {}
  
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}