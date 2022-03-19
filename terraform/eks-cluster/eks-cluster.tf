module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "v18.11.0"

  cluster_name                    = "${local.k8s_cluster_name}-${terraform.workspace}"
  cluster_version                 = var.k8s_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true


  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id = data.terraform_remote_state.core-networking.outputs.vpc_id
  subnet_ids = flatten([
    data.terraform_remote_state.core-networking.outputs.private_subnets,
    data.terraform_remote_state.core-networking.outputs.public_subnets
  ])

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = var.ami_type
    disk_size      = var.nodegroup_disk_size
    instance_types = var.nodegroup_instance_types
    #vpc_security_group_ids = [aws_security_group.additional.id]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = var.nodegroup_min_size
      max_size     = var.nodegroup_max_size
      desired_size = var.nodegroup_desired_size

      capacity_type = var.capacity_type
      labels = {
        Environment = terraform.workspace
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }
    }
  }

  tags = {
    Environment = terraform.workspace
    Terraform   = "true"
  }
}