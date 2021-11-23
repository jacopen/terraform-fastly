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

  force_destroy = true
}