resource "aws_vpc" "vpc_eks" {
  cidr_block       = "172.16.0.0/20"
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    repository_name = var.tag_repo_name
  }
}

resource "aws_subnet" "private_subnet_aza" {
  vpc_id            = aws_vpc.vpc_eks.id
  cidr_block        = "172.16.4.0/22"
  availability_zone = "sa-east-1a"

  tags = {
    repository_name = var.tag_repo_name
  }
}

resource "aws_subnet" "private_subnet_azb" {
  vpc_id            = aws_vpc.vpc_eks.id
  cidr_block        = "172.16.8.0/22"
  availability_zone = "sa-east-1b"

  tags = {
    repository_name = var.tag_repo_name
  }
}

resource "aws_subnet" "private_subnet_azc" {
  vpc_id            = aws_vpc.vpc_eks.id
  cidr_block        = "172.16.12.0/22"
  availability_zone = "sa-east-1c"

  tags = {
    repository_name = var.tag_repo_name
  }
}


resource "aws_security_group" "main" {
  name        = "Allow vpc_eks"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_eks.id

  tags = {
    repository_name = var.tag_repo_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = aws_vpc.vpc_eks.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}