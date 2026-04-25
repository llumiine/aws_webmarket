#définit les réseaux principaux (VPC) pour les environnements prod et test
resource "aws_vpc" "prod" {
  cidr_block           = var.prod_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-prod-vpc"
    Environment = "prod"
  }
}

resource "aws_vpc" "test" {
  cidr_block           = var.test_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-test-vpc"
    Environment = "test"
  }
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name        = "${var.project_name}-prod-igw"
    Environment = "prod"
  }
}

resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name        = "${var.project_name}-test-igw"
    Environment = "test"
  }
}