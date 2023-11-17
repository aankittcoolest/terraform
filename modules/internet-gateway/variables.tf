variable "vpc_id" {
    description = "VPC Id"
    type = string
    default = ""
}

variable "tags" {
    description = "Tags"
    type = map(string)
    default = {}
  
}