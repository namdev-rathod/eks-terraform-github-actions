output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "vpc_id" {
  description = "Created VPC ID"
  value       = module.vpc.vpc_id
}
