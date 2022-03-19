# in addition to our regular aws provider, Argo requires k8s and helm:
provider "kubernetes" {
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks-cluster.outputs.eks_cluster_certificate_data)
  host                   = data.terraform_remote_state.eks-cluster.outputs.eks_cluster_endpoint
  exec {
    # api_version requirements might differ on aws-iam-authenticator versions older than 0.5.4
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", data.terraform_remote_state.eks-cluster.outputs.eks_cluster_id]
  }
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks-cluster.outputs.eks_cluster_certificate_data)
    host                   = data.terraform_remote_state.eks-cluster.outputs.eks_cluster_endpoint
    exec {
      # api_version requirements might differ on aws-iam-authenticator versions older than 0.5.4
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws-iam-authenticator"
      args        = ["token", "-i", data.terraform_remote_state.eks-cluster.outputs.eks_cluster_id]
    }
  }
}

### Creating a namespace using kubernetes provider
resource "kubernetes_namespace" "argocd" {
  count = var.install_argo ? 1 : 0
  metadata {
    name = var.kubernetes_namespace_for_argocd
  }
}


### Installing Argo in its namespace using Helm provider
resource "helm_release" "argocd" {
  count      = var.install_argo ? 1 : 0
  version    = var.argo_chart_version
  name       = var.helm_release_name
  chart      = var.helm_release_chart
  repository = var.argo_repo_source
  namespace  = var.kubernetes_namespace_for_argocd
#  values = [
#    data.template_file.values-override.rendered
#  ]
}

#### App for Argo
#data "template_file" "values-override" {
#  template = file("${path.module}/files/values-override.tpl")
#  vars = {
#    argocd_git_repo_path_name = var.argocd_git_repo_path_name
#    argocd_git_repo_path      = var.argocd_git_repo_path
#  }
#}
