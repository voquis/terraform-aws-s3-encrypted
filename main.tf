terraform {
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create S3 Bucket
# Provider Docs: https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "this" {
  bucket = var.bucket
  acl    = var.acl
  tags   = var.tags

  force_destroy = var.force_destroy
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

# ---------------------------------------------------------------------------------------------------------------------
# Create a versioning configuration resource on S3 Bucket.
#
# For MFA delete details, see:
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiFactorAuthenticationDelete.html
#
# Provider Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket_versioning" "this" {
  count = var.versioning_enabled ? 1 : 0

  bucket                = aws_s3_bucket.this.id
  expected_bucket_owner = var.versioning_expected_bucket_owner
  mfa                   = var.versioning_mfa

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = var.versioning_mfa_delete
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create a server side encryption resource on S3 Bucket.
#
# For S3 Bucket keys to save KMS costs, see:
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html
#
# Provider Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket                = aws_s3_bucket.this.id
  expected_bucket_owner = var.versioning_expected_bucket_owner

  rule {
    bucket_key_enabled = var.bucket_key_enabled

    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_id == null ? "AES256" : "aws:kms"
      kms_master_key_id = var.kms_key_id
    }
  }
}
