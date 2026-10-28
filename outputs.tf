output "state_bucket_name" {
  description = "S3 bucket for Terraform state."
  value       = module.s3_backend.bucket_name
}

output "lock_table_name" {
  description = "DynamoDB table used for Terraform state locking."
  value       = module.s3_backend.dynamodb_table_name
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets."
  value       = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  description = "URL of the ECR repository."
  value       = module.ecr.repository_url
}
