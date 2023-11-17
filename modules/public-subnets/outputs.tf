data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  tags = {
    tier = "public"
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.public_subnets.ids)
  id       = each.value
}

output "subnet_ids" {
  value = [for s in data.aws_subnet.subnet : s.id]
}

output "subnet_id" {
  value = data.aws_subnets.public_subnets.ids[0]
}
