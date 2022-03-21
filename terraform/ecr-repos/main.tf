resource "aws_ecr_repository" "app" {
  name = var.repository

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_repository_policy" "app" {
  repository = var.repository
  policy     = local.policy

  depends_on = [aws_ecr_repository.app]
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = var.repository

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 10,
      "description": "Remove untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF

  depends_on = [aws_ecr_repository.app]
}

