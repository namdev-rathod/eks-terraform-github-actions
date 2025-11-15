terraform {
  backend "s3" {
    bucket  = "eks-devops-tf-backend"
    key     = "eks/dev/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

# -------------------------
# VPC Module
# -------------------------
module "vpc" {
  source   = "../../modules/vpc"

  vpc_cidr = var.vpc_cidr
  env      = var.env
}

# -------------------------
# EKS Module
# -------------------------
module "eks" {
  source           = "../../modules/eks"

  cluster_name     = var.cluster_name
  node_group_name  = var.node_group_name

  # Use module outputs from VPC
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
}
