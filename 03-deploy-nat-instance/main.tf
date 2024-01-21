module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "main"
  cidr                 = "10.0.0.0/16"
  azs                  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets      = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
}

module "nat" {
 source = "int128/nat-instance/aws"

  name                        = "main"
  vpc_id                      = module.vpc.vpc_id
  public_subnet               = module.vpc.public_subnets[0]
  private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  private_route_table_ids     = module.vpc.private_ipv6_egress_route_ids
}

resource "aws_eip" "nat" {
  network_interface = module.nat.eni_id
  tags = {
    name = "nat-instance-main"
  }
}
