module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    devops_nodes = {
      instance_types = ["t4g.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      name           = var.node_group_name
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
