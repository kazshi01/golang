resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# Public Subunetに関連付けるルートテーブル
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0" # すべてのトラフィック
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-route-table"
  }
}

# ルートテーブルをPublicサブネットに関連付ける
resource "aws_route_table_association" "public_route_table_assoc" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Subnetに関連付けるルートテーブル
# NAT Gateway
resource "aws_eip" "nat_eip" {
  count = var.public ? 0 : 1
  tags = {
    Name = "${var.name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  count         = var.public ? 0 : 1
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id     = aws_subnet.public_subnets["1"].id

  tags = {
    Name = "${var.name}-nat-gateway"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  dynamic "route" {
    for_each = var.public ? [] : [1]
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gw[0].id
    }
  }

  tags = {
    Name = "${var.name}-private-route-table"
  }
}

resource "aws_route_table_association" "private_route_table_assoc" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}

# Database Subnetに関連付けるルートテーブル

resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-database-route-table"
  }
}

resource "aws_route_table_association" "database_route_table_assoc" {
  for_each       = aws_subnet.database_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.database_route_table.id
}
