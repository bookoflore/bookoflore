provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "chronicle-cluster"
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  node_groups = {
    chronicle_nodes = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity    = 2

      instance_type = "t3.large"
      key_name      = aws_key_pair.chronicle_key.key_name

      additional_tags = {
        Environment = "production"
        Application = "chronicle"
      }
    }
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "chronicle-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

resource "aws_ecr_repository" "chronicle" {
  name = "chronicle-system"
  image_scanning_configuration {
    scan_on_push = true
  }
}
