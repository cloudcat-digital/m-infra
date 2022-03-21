terraform {
  required_version = "1.1.4"

  backend "s3" {
    bucket      = "cloudcat-tf-state"
    key         = "cloudcat-vcn"
    region      = "eu-west-1"
    encrypt     = true
    max_retries = 30
  }
}