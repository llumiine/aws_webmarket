#ce fichier crée un bucket S3 privé pour représenter le stockage
#info: Le bucket est chiffré au repos et l'accès public est bloqué 
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "app_files" {
  bucket = "${var.project_name}-files-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-files"
    Environment = "shared"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_files" {
  bucket = aws_s3_bucket.app_files.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "app_files" {
  bucket = aws_s3_bucket.app_files.id
  #évitent qu’un fichier soit exposé publiquement par erreur
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}