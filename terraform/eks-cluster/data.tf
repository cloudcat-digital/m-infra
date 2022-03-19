data "aws_caller_identity" "current" {
}

data "terraform_remote_state" "core-networking" {
  backend   = "s3"
  #workspace = terraform.workspace

  config = {
    bucket   = "cloudcat-tf-state"
    key      = "cloudcat-vcn"
    region   = "eu-west-1"
  }
}
