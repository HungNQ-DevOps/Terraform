# VPC creation
resource "aws_vpc" "demo_terraform" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "public-subnet"
  }
}

# Internet gateway configuration
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.demo_terraform.id
  tags = {
    Name = "demo-terraform"
    Type = "demo"
  }
}

# Subnet

### Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo_terraform.id
  cidr_block = var.public_subnet["cidr"]
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet["subnet_name"]
  }
  depends_on = [
    aws_internet_gateway.gw,
    aws_vpc.demo_terraform
  ]
}

### Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo_terraform.id
  cidr_block = var.private_subnet["cidr_01"]
  availability_zone = "${var.region}b"
  tags = {
    Name = var.private_subnet["subnet_name"]
  }
  depends_on = [
    aws_internet_gateway.gw,
    aws_vpc.demo_terraform
  ]
}

# Route table

### Public subnet => Route table configuration
resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.demo_terraform.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet.id
}

### Private subnet => Route table configuration
resource "aws_route_table" "private_subnet" {
  vpc_id = aws_vpc.demo_terraform.id
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.gw.id
  # }
}

resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet.id
}

# DB Subnet group
resource "aws_db_subnet_group" "demo_terraform" {
  name = "demo_terrform_db_subnet_group"
  subnet_ids = [
    aws_subnet.public_subnet.id,
    aws_subnet.private_subnet.id
  ]
}