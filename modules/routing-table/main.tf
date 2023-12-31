resource "aws_route_table" "routing_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = var.tags
}

resource "aws_route_table_association" "route_table_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.routing_table.id
}
