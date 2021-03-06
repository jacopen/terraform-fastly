resource "aws_s3_bucket" "jacopen_fastly_test" {
  bucket = "jacopen-fastly-website"
  acl    = "public-read"
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "jacopen_fastly_test" {
  bucket = aws_s3_bucket.jacopen_fastly_test.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "bucketpolicy"
    Statement = [
      {
        Sid       = "AddPerm"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          "${aws_s3_bucket.jacopen_fastly_test.arn}/*"
        ]
      },
    ]
  })
}

resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${path.module}/website s3://${aws_s3_bucket.jacopen_fastly_test.id}"
  }
}

data "terraform_remote_state" "ui_app" {
  backend = "remote"

  config = {
    organization = "kusama"
    workspaces = {
      name = "terraform-fastly-app"
    }
  }
}