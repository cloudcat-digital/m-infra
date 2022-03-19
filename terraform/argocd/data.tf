data "terraform_remote_state" "eks-cluster" {
  backend   = "s3"
  #workspace = terraform.workspace

  config = {
    bucket   = "cloudcat-tf-state"
    key      = "eks-cluster"
    region   = "eu-west-1"
  }
}