resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id = var.vpc_id
    cidr_block = element(var.public_subnet_cidrs, count.index)
    availability_zone = element(var.azs,count.index)
    tags = var.tags
}