terraform {
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create S3 Bucket
# Provider Docs: https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "this" {
  region = var.region
  bucket = var.bucket
  versioning {
    enabled = var.versioning_enabled
  }
  force_destroy = var.force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
      }
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create a block on public access for S3 Bucket
# Note this does not affect a CloudFront distribution if configured correctly.
# By setting all values to true, will show as block all public access: ON in console.
# Provider Docs: # https://www.terraform.io/docs/providers/aws/r/s3_bucket_public_access_block.html
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
