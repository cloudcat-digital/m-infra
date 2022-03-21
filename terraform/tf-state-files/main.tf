### This is a terraform pre-req that we have to do in 2 steps:
###
### step 1: create this S3 bucket used for tf state
### step 2: migrate the existing state by uncommenting the S3 backend and re-running tf init

module "s3_bucket" {
  source                  = "terraform-aws-modules/s3-bucket/aws"
  version                 = "v2.15.0"
  bucket                  = "cloudcat-tf-state"
  acl                     = "private"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

}
