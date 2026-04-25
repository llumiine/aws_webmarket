# Ce fichier crée les sous-réseaux privés des environnements prod et test et les tables de routage
resource "aws_subnet" "prod_private" {
  count = length(var.prod_private_subnets)

  vpc_id            = aws_vpc.prod.id
  cidr_block        = var.prod_private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.project_name}-prod-private-${count.index + 1}"
    Environment = "prod"
    Type        = "private"
  }
}

resource "aws_route_table" "prod_private" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name        = "${var.project_name}-prod-private-rt"
    Environment = "prod"
  }
}

resource "aws_route_table_association" "prod_private" {
  count = length(aws_subnet.prod_private)

  subnet_id      = aws_subnet.prod_private[count.index].id
  route_table_id = aws_route_table.prod_private.id
}

resource "aws_subnet" "test_private" {
  count = length(var.test_private_subnets)

  vpc_id            = aws_vpc.test.id
  cidr_block        = var.test_private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.project_name}-test-private-${count.index + 1}"
    Environment = "test"
    Type        = "private"
  }
}

resource "aws_route_table" "test_private" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name        = "${var.project_name}-test-private-rt"
    Environment = "test"
  }
}

resource "aws_route_table_association" "test_private" {
  count = length(aws_subnet.test_private)

  subnet_id      = aws_subnet.test_private[count.index].id
  route_table_id = aws_route_table.test_private.id
}