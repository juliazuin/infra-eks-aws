resource "aws_vpc" "vpc_eks" {
  cidr_block       = "172.16.0.0"
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

