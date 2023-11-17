
resource "aws_vpc" "_" {
    cidr_block = var.cidr_block
    tags = var.tags
}