terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

module "vpc" {
  source = "./vpc.tf"
}

module "eks" {
  source = "./eks-cluster.tf"
}

module "sqs" {
  source = "./sqs.tf"
}