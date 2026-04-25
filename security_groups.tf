#le fichier définit les règles réseau au Load Balancer
# et aux instances EC2 des environnements prod et test
resource "aws_security_group" "prod_alb" {
  name        = "${var.project_name}-prod-alb-sg"
  description = "securite group pour le ALB de prod"
  vpc_id      = aws_vpc.prod.id

  ingress {
    description = "HTTP depuis Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Tout le trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-prod-alb-sg"
    Environment = "prod"
  }
}

resource "aws_security_group" "prod_ec2" {
  name        = "${var.project_name}-prod-ec2-sg"
  description = "Securite group de prod EC2"
  vpc_id      = aws_vpc.prod.id

  ingress {
    description     = "HTTP depuis ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_alb.id]
  }

  ingress {
    description = "SSH depuis mon IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "Tout le trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-prod-ec2-sg"
    Environment = "prod"
  }
}

resource "aws_security_group" "test_ec2" {
  name        = "${var.project_name}-test-ec2-sg"
  description = "Securite group pour le EC2 de test"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "HTTP depuis Internet pour la demo"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH depuis mon IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "Tout le trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-test-ec2-sg"
    Environment = "test"
  }
}