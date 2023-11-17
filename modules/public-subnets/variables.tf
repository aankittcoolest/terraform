variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
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