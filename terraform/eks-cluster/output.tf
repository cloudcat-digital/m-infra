output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_certificate_data" {
  value = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
