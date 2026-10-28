module "s3_backend" {
  source            = "./modules/s3-backend"
  bucket_name       = var.state_bucket_name
  dynamodb_table_name = "${var.project_name}-terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "${var.project_name}-vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.ecr_repository_name
  scan_on_push    = var.ecr_scan_on_push
}

module "s3_backend" {

 source = "./modules/s3-backend" # Шлях до модуля

 bucket_name = "terraform-state-bucket-001001" # Ім'я S3-бакета

 table_name = "terraform-locks" # Ім'я DynamoDB

}

module "vpc" {

 source = "./modules/vpc" # Шлях до модуля VPC

 vpc_cidr_block = "10.0.0.0/16" # CIDR-блок для VPC

 public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Публічні підмережі

 private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] # Приватні підмережі

 availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"] # Зони доступності

 vpc_name = "vpc" # Ім'я VPC

}

module "ecr" {

 source = "./modules/ecr" # Шлях до модуля

 repository_name = "app-repo" # Назва репозиторію

 environment = "dev" # Середовище

}

module "eks" {

  source          = "./modules/eks"          

  cluster_name    = "eks-cluster-demo"            # Назва кластера

  subnet_ids      = module.vpc.public_subnets     # ID підмереж

  instance_type   = "t2.micro"                    # Тип інстансів

  desired_size    = 1                             # Бажана кількість нодів

  max_size        = 2                             # Максимальна кількість нодів

  min_size        = 1                             # Мінімальна кількість нодів

}

#-------------Backend-----------------

output "s3_bucket_name" {

 description = "Name of the S3 bucket for storing Terraform state files"

 value = module.s3_backend.s3_bucket_name

}

output "dynamodb_table_name" {

 description = "Name of the DynamoDB table for state locking"

 value = module.s3_backend.dynamodb_table_name

}

#-------------VPC-----------------


output "vpc_id" {

  description = "ID of the created VPC"

  value       = module.vpc.vpc_id

}


output "public_subnets" {

  description = "List of public subnet IDs"

  value       = module.vpc.public_subnets

}


output "private_subnets" {

  description = "List of private subnet IDs"

  value       = module.vpc.private_subnets

}


output "internet_gateway_id" {

  description = "ID of the Internet Gateway"

  value       = module.vpc.internet_gateway_id

}

#-------------EKS-----------------


output "eks_cluster_endpoint" {

  description = "EKS API endpoint for connecting to the cluster"

  value       = module.eks.eks_cluster_endpoint

}


output "eks_cluster_name" {

  description = "Name of the EKS cluster"

  value       = module.eks.eks_cluster_name

}


output "eks_node_role_arn" {

  description = "IAM role ARN for EKS Worker Nodes"

  value       = module.eks.eks_node_role_arn

}