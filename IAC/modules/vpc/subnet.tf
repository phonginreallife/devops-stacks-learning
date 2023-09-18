data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnets" {
  count                   = var.vpc_subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = (cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index))
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.system_name}-public-subnet-${count.index}"
    Terraform = "true"
    Environment = "prod"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_subnets" {
  count = var.vpc_subnet_count
  depends_on = [
    aws_subnet.public_subnets
  ]

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index + 3)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.system_name}-private-subnet-${count.index}"
  }
}
resource "aws_subnet" "database_subnets" {
  count = var.vpc_subnet_count
  depends_on = [
    aws_subnet.public_subnets
  ]

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index + 6)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.system_name}-database-subnet-${count.index}"
  }
}
resource "aws_db_subnet_group" "database_subnets" {
  count = var.vpc_subnet_count

  name        = var.database_subnet_group_name
  description = "Database subnet group for ${var.name}"
  subnet_ids  = aws_subnet.database_subnets[*].id

  tags = merge(
    var.tags,
    var.database_subnet_group_tags,
  )
}