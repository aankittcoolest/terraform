data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    tier = "private"
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
}

output "subnet_ids" {
  value = [for s in data.aws_subnet.subnet : s.id]
}

output "subnet_id" {
  value = length(data.aws_subnets.private_subnets.ids) > 0 ? data.aws_subnets.private_subnets.ids[0] : ""
}