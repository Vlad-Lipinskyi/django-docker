variable "vpc_name" { type = string }
variable "vpc_cidr_block" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "availability_zones" { type = list(string) }

variable "nat_gateway_per_az" {
  description = "Create one NAT Gateway per AZ (more resilient, higher cost); false creates one shared NAT."
  type        = bool
  default     = false
}
