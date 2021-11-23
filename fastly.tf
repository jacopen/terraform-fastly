resource "fastly_service_v1" "prod" {
  name = "prod"

  domain {
    name    = "prod.udcp.info"
    comment = "service for production"
  }

  force_destroy = true
}