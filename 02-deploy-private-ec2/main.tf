provider "aws" {
  region = "ap-southeast-1"
}

module "vpc" {
  source     = "../modules/vpc"
  cidr_block = "10.0.0.0/16"
  tags = {
    terraform   = "true"
    environment = "dev"
  }
}

module "public-subnets" {
  source              = "../modules/public-subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  tags = {
    terraform   = "true"
    environment = "dev"
    tier        = "public"
  }
}

module "private-subnets" {
  source               = "../modules/private-subnets"
  vpc_id               = module.vpc.vpc_id
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  tags = {
    terraform   = "true"
    environment = "dev"
    tier        = "private"
  }
}

module "internet-gateway" {
  source = "../modules/internet-gateway"
  vpc_id = module.vpc.vpc_id
  tags = {
    terraform   = "true"
    environment = "dev"
  }
}

module "routing-table" {
  source              = "../modules/routing-table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet-gateway.internet_gateway_id
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = module.public-subnets.subnet_ids
  tags = {
    terraform   = "true"
    environment = "dev"
  }
  depends_on = [module.internet-gateway, module.public-subnets]
}

module "public-security-group" {
  source = "../modules/web-security-group"
  name = "public-sg-http-and-ssh"
  vpc_id = module.vpc.vpc_id
  cidr_blocks = ["0.0.0.0/0"]
}

module "private-security-group" {
  source = "../modules/web-security-group"
  name = "private-sg-http-and-ssh"
  vpc_id = module.vpc.vpc_id
  cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# create ec2 instance in private subnet
module "ec2-private" {
  source            = "../modules/ec2"
  ami_id            = "ami-02453f5468b897e31"
  instance_type     = "t2.micro"
  subnet_id         = module.private-subnets.subnet_id
  security_group_id = module.private-security-group.security_group_id
}

# create ec2 instance in public subnet
module "ec2-public" {
  source            = "../modules/ec2"
  ami_id            = "ami-02453f5468b897e31"
  instance_type     = "t2.micro"
  subnet_id         = module.public-subnets.subnet_id
  security_group_id = module.public-security-group.security_group_id
}