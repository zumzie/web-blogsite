provider "aws" {
    region = ""
}


# VPC
module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = ""
    name    = "enterprise-vpc"
    cidr    = "10.0.0.0/16"
    azs     = [""]
    public_subnets = []
    private_subnets = []
}

# EC2 Instance for Jenkins
resource "aws_instance" "jenkins" {
    ami = ""
    instance_type = ""
    subnet_id = module.vpc.public_subnets[0]

    tags = {
        Name = "Jenkins-Server"
    }
}

# EKS Cluster
module "eks" {
    source          = "terraform-aws-modules/eks/aws"
    cluster_name    = "enterprise-eks-cluster"
    cluster_version = ""
    subnets         = module.vpc.private_subnets
    vpc_id          = module.vpc.vpc_id

    node_groups = {
        eks_nodes = {
            desired_capacity    = 2
            max_capacity        = 3
            min_capacity        = 1
            instance_type       = ""
        }
    }
}