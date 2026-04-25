#Ce fichier centralise les paramètres du projet AWS :région, profil AWS, nom du projet,etc

variable "aws_region" {
  description = "Region AWS cible"
  type        = string
  default     = "eu-west-3"
}

variable "aws_profile" {
  description = "Profil AWS CLI utilise pour deployer"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Prefixe de nommage des ressources"
  type        = string
  default     = "webmarket"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name doit contenir uniquement: a-z, 0-9, -"
  }
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "IP autorisee en SSH au format x.x.x.x/32"
  type        = string
  default     = "78.192.144.136/32"

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/32$", var.my_ip))
    error_message = "my_ip doit etre une IPv4 au format /32 (ex: 1.2.3.4/32)."
  }
}

variable "prod_vpc_cidr" {
  description = "CIDR du VPC de production"
  type        = string
  default     = "10.0.0.0/16"
}

variable "test_vpc_cidr" {
  description = "CIDR du VPC de test"
  type        = string
  default     = "10.10.0.0/16"
}

variable "prod_public_subnets" {
  description = "CIDR des subnets publics prod"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "prod_private_subnets" {
  description = "CIDR des subnets prives prod"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "test_public_subnets" {
  description = "CIDR des subnets publics test"
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "test_private_subnets" {
  description = "CIDR des subnets prives test"
  type        = list(string)
  default     = ["10.10.11.0/24"]
}

variable "prod_cpu_alarm_evaluation_periods" {
  description = "Nombre de periodes pour confirmer l'alarme CPU prod"
  type        = number
  default     = 2
}

variable "prod_cpu_alarm_period" {
  description = "Periode CloudWatch (en secondes) pour la metrique CPU prod"
  type        = number
  default     = 300
}

variable "prod_cpu_alarm_threshold" {
  description = "Seuil CPU (%) qui declenche l'alarme prod"
  type        = number
  default     = 70
}
variable "key_name" {
  description = "Nom de la key pair AWS pour se connecter en SSH aux EC2"
  type        = string
  default     = "webmarket-key"
}