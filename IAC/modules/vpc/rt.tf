#<your code here>

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = {
    Name = "public-route-table-${local.name}"
  }
  
}

resource "aws_route" "public_gw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route" "private_gw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}

resource "aws_route_table_association" "private_assoc" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private-database-route-table"
  }
}

resource "aws_route" "private_database_gw" {
  route_table_id         = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}

resource "aws_route_table_association" "private_database_assoc" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.database_subnets[count.index].id
  route_table_id = aws_route_table.database.id
}