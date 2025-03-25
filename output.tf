# Output Website URL
output "website_url" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
  description = "URL of the static website"
}
