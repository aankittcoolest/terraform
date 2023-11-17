
variable "tags" {
    description = "Tags for EC2 instance"
    type = map(string)
    default = {}
  
}

variable "ami_id" {
    description = "AMI ID"
    type = string
    default = ""
}

variable "instance_type" {
    description = "Instance type"
    type = string
    default = ""
}

variable "key_name" {
    description = "SSH key"
    type = string
    default = "MyKeyPair"
}

variable "subnet_id" {
    description = "subnet_id"
    type = string
    default = ""
}

variable "security_group_id" {
    description = "Security group ID"
    type = string
    default = ""
}