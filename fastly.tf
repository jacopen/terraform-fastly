resource "fastly_service_v1" "prod" {
  name = "prod"

  domain {
    name    = "prod.udcp.info"
    comment = "service for production"
  }
  
  backend {
    address = aws_s3_bucket.jacopen_fastly_test.website_endpoint
    name    = "website"
    port    = "80"
    override_host = aws_s3_bucket.jacopen_fastly_test.website_endpoint
  }

  backend {
    address = data.terraform_remote_state.ui_app.jacopen_fastly_ui_website_endpoint
    name    = "ui"
    port    = "80"
    override_host = data.terraform_remote_state.ui_app.jacopen_fastly_ui_website_endpoint
  }

  vcl {
    name    = "custom_vcl"
    content = "${file("${path.module}/vcl/custom.vcl")}"
    main    = true
  }

  snippet {
    name    = "miss_vcl"
    content = "${file("${path.module}/vcl/miss_snippet.vcl")}"
    type    = "miss"
  }

  force_destroy = true
}