locals {
  azs = {
    "1" = "ap-northeast-1a"
    "2" = "ap-northeast-1c"
    "3" = "ap-northeast-1d"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each          = { for k, v in local.azs : k => v }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, tonumber(each.key))
  availability_zone = each.value

  # EC2インスタンスにパブリックIPを自動割り当て
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each          = { for k, v in local.azs : k => v }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, tonumber(each.key) + 4)
  availability_zone = each.value

  tags = {
    Name = "${var.name}-private-subnet-${each.key}"
  }
}

resource "aws_subnet" "database_subnets" {
  for_each          = { for k, v in local.azs : k => v }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, tonumber(each.key) + 8)
  availability_zone = each.value

  tags = {
    Name = "${var.name}-database-subnet-${each.key}"
  }
}
