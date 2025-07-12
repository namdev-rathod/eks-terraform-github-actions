variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "env" {
  description = "Environment tag (e.g. dev, prod)"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS Node Group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}
