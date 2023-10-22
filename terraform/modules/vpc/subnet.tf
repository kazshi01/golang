locals {
  azs = {
    "1" = "ap-northeast-1a"
    "2" = "ap-northeast-1c"
    "3" = "ap-northeast-1d"
  }
}

locals {
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 8)]
}

resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(local.public_subnets)
  cidr_block        = local.public_subnets[count.index]
  availability_zone = local.azs[tostring(count.index + 1)]
  # EC2インスタンスにパブリックIPを自動割り当て
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(local.private_subnets)
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.azs[tostring(count.index + 1)]
  tags = {
    Name = "${var.name}-private-subnet"
  }
}

resource "aws_subnet" "database_subnets" {
  vpc_id            = aws_vpc.main.id
  count             = length(local.database_subnets)
  cidr_block        = local.database_subnets[count.index]
  availability_zone = local.azs[tostring(count.index + 1)]
  tags = {
    Name = "${var.name}-database-subnet"
  }
}

