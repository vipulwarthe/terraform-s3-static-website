variable "aws_region" {
  description = "AWS region for S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
  default     = "ml-books-static-site"
}

variable "index_html" {
  description = "Path to the index.html file"
  type        = string
  default     = "index.html"
}

variable "error_html" {
  description = "Path to the error.html file"
  type        = string
  default     = "error.html"
}

