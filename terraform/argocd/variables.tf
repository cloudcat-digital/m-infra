variable "argo_repo_source" {
  type    = string
  default = "https://argoproj.github.io/argo-helm"
}

variable "argo_chart_version" {
  type    = string
  default = "3.35.4"
}

variable "kubernetes_namespace_for_argocd" {
  type    = string
  default = "argo"
}

variable "helm_release_name" {
  type    = string
  default = "gitops"
}

variable "helm_release_chart" {
  type    = string
  default = "argo-cd"
}

variable "install_argo" {
  type    = bool
  default = true
}

variable "argocd_git_repo_path_name" {
  type    = string
  default = ""
}

variable "argocd_git_repo_path" {
  type    = string
  default = ""
}