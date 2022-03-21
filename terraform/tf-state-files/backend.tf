# S3 backend initially commented out
# uncomment and re-init tf after creating the S3 bucket

terraform {
  required_version = "1.1.4"

  backend "s3" {
    bucket      = "cloudcat-tf-state"
    key         = "tf_state"
    region      = "eu-west-1"
    encrypt     = true
    max_retries = 30
  }
}