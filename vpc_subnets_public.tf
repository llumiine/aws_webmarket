# crée les sous-réseaux publics des environnements
resource "aws_subnet" "prod_public" {
  count = length(var.prod_public_subnets)

  vpc_id                  = aws_vpc.prod.id
  cidr_block              = var.prod_public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-prod-public-${count.index + 1}"
    Environment = "prod"
    Type        = "public"
  }
}

resource "aws_route_table" "prod_public" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name        = "${var.project_name}-prod-public-rt"
    Environment = "prod"
  }
}

resource "aws_route" "prod_public_internet" {
  route_table_id         = aws_route_table.prod_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.prod.id
}

resource "aws_route_table_association" "prod_public" {
  count = length(aws_subnet.prod_public)

  subnet_id      = aws_subnet.prod_public[count.index].id
  route_table_id = aws_route_table.prod_public.id
}

resource "aws_subnet" "test_public" {
  count = length(var.test_public_subnets)

  vpc_id                  = aws_vpc.test.id
  cidr_block              = var.test_public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-test-public-${count.index + 1}"
    Environment = "test"
    Type        = "public"
  }
}

resource "aws_route_table" "test_public" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name        = "${var.project_name}-test-public-rt"
    Environment = "test"
  }
}

resource "aws_route" "test_public_internet" {
  route_table_id         = aws_route_table.test_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test.id
}

resource "aws_route_table_association" "test_public" {
  count = length(aws_subnet.test_public)

  subnet_id      = aws_subnet.test_public[count.index].id
  route_table_id = aws_route_table.test_public.id
}