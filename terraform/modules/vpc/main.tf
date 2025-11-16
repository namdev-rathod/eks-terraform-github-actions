data "aws_availability_zones" "available" {}

#
# VPC
#
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

#
# PUBLIC SUBNETS  (2 AZs)
#
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id

  # Use safe non-overlapping subnets
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)    # /20 subnets
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-subnet-${count.index}"
    "kubernetes.io/role/elb" = "1"
  }
}

#
# PRIVATE SUBNETS (2 AZs)
#
resource "aws_subnet" "private" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id

  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index + 2)  # next /20 blocks
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}-private-subnet-${count.index}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

#
# INTERNET GATEWAY
#
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

#
# PUBLIC ROUTE TABLE
#
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_association" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#
# NAT GATEWAY
#
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}

#
# PRIVATE ROUTE TABLE
#
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_association" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
