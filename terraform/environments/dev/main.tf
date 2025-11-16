terraform {
  backend "s3" {
    bucket  = "eks-devops-tf-backend"
    key     = "eks/dev/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  env      = var.env
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8"

  cluster_name    = var.cluster_name
  cluster_version = "1.34"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    devops_nodes = {
      name            = var.node_group_name
      use_name_prefix = false

      instance_types = ["t4g.medium"]
      ami_type       = "AL2023_ARM_64_STANDARD"

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  tags = {
    Environment = var.env
    Terraform   = "true"
  }
}
