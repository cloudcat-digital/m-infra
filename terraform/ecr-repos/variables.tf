variable "repository" {
  type = string
  default = "cloudcat/app"
}

variable "principal_arns" {
  type        = list(string)
  description = "ARNs of principals permitted to push images to the repository"

  default = [
    "730000042845"
  ]
}

locals {
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "ecr-access-control",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    ${join(",", formatlist("\"%s\"", var.principal_arns))}
                ]
            },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability"
            ]
        },
        {
            "Sid": "ecr-push-image",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    ${join(",", formatlist("\"%s\"", var.principal_arns))}
                ]
            },
            "Action": [
                "ecr:InitiateLayerUpload",
                "ecr:CompleteLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:PutImage"
            ]
        }
    ]
}
EOF

}

