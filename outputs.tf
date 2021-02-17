output "s3_bucket" {
  value = aws_s3_bucket.this
}

output "s3_bucket_public_access_block" {
  value = aws_s3_bucket_public_access_block.this
}
