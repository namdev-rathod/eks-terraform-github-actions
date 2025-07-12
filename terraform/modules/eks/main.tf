variable "cluster_name" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    devops_nodes = {
      name           = var.node_group_name
      instance_types = ["t4g.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

output "cluster_name" {
  value = module.eks.cluster_name
}
