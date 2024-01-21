
provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    env = "dev"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "private_subnet" {
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.4.0/24"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    env    = "dev"
    subnet = "private"
  }
}

resource "aws_security_group" "private-instance-security-group" {
  name        = "security-group"
  description = "Security group"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }
  tags = {
    env = "dev"
  }
}

resource "aws_instance" "private-ec2-instance" {
  instance_type           = "t2.micro"
  ami                     = ""
  subnet_id               = aws_subnet.private_subnet.id
  security_groups         = [aws_security_group.private-instance-security-group.id]
  key_name                = "MyKeyPair"
  disable_api_termination = false
  ebs_optimized           = false
  root_block_device {
    volume_size = "10"
  }
  tags = {
    env      = "dev"
    instance = "private"
  }
}

output "instance_private_ip" {
  value = aws_instance.private-ec2-instance.private_ip
}

resource "aws_subnet" "public-subet" {
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    env    = "dev"
    subnet = "public"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    env = "dev"
  }
}

resource "aws_route_table" "internet-gateway-to-internet" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_route_table_association" "internet-gw-public-subnet-assoc" {
  subnet_id      = aws_subnet.public-subet.id
  route_table_id = aws_route_table.internet-gateway-to-internet.id
}

resource "aws_eip" "nat-gateway-eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-gateway-eip.id
  subnet_id     = aws_subnet.private_subnet.id
  tags = {
    env = "dev"
  }

}

output "nat_gateway_eip" {
    value = aws_eip.nat-gateway-eip.public_ip
}

resource "aws_route_table" "nat-gateway-to-internet" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway.id
    }
}

resource "aws_route_table_association" "nat-gw-private-subnet-assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.nat-gateway-to-internet.id
}