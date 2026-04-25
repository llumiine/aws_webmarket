# Outputs qui permet de récupérer les informations clés du déploiement :
# URL des applications, IP de test, VPC et S3
output "prod_alb_dns_name" {
  description = "URL du Load Balancer de production"
  value       = "http://${aws_lb.prod.dns_name}"
}

output "test_ec2_public_ip" {
  description = "IP publique de l'EC2 de test"
  value       = aws_instance.test_web.public_ip
}

output "test_ec2_url" {
  description = "URL de l'EC2 de test"
  value       = "http://${aws_instance.test_web.public_ip}"
}

output "prod_vpc_id" {
  description = "ID du VPC de production"
  value       = aws_vpc.prod.id
}

output "test_vpc_id" {
  description = "ID du VPC de test"
  value       = aws_vpc.test.id
}

output "s3_bucket_name" {
  description = "Nom du bucket S3"
  value       = aws_s3_bucket.app_files.bucket
}