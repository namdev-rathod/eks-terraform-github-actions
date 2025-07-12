terraform {
  backend "s3" {
    bucket = "eks-devops-tf-backend"
    key    = "eks/dev/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  env      = "dev"
}

module "eks" {
  source           = "../../modules/eks"
  cluster_name     = "EKS-DevOps-Cluster"
  node_group_name  = "EKS-DevOps-Cluster-NodeGroup"
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
}
