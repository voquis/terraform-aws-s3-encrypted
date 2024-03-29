# ---------------------------------------------------------------------------------------------------------------------
# Required variables
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket" {
  description = "Bucket name to use, must be unique in region. Random name generated if omitted"
  type        = string
  default     = null
}

variable "block_public_acls" {
  description = "Whether or not to block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether or not to block public policies"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Empty and remove bucket on destroy"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether or not to ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether or not to restrict public buckets"
  type        = bool
  default     = true
}

variable "versioning_enabled" {
  description = "Whether to enable bucket versioning so that deletions and versions are retained"
  type        = bool
  default     = true
}

variable "versioning_mfa_delete" {
  description = "Whether to require MFA when permanently deleting an object or changing versioning state"
  type        = string
  default     = "Disabled"
}

variable "versioning_mfa" {
  description = "MFA device if MFA delete is enabled"
  type        = string
  default     = null
}

variable "versioning_expected_bucket_owner" {
  description = "Account ID of the expected bucket owner"
  type        = string
  default     = null
}

variable "acl" {
  description = "Canned access control policy options for the s3 bucket"
  type        = string
  default     = "private"
}

variable "object_ownership" {
  description = "Object ownership"
  type        = string
  default     = "BucketOwnerPreferred"
}

variable "tags" {
  description = "Map of key value pairs for tags"
  type        = map(string)
  default     = null
}

variable "kms_key_id" {
  description = "Existing kms key id"
  type        = string
  default     = null
}

variable "bucket_key_enabled" {
  description = "Whether to use short-lived bucket keys to save on KMS costs"
  type        = bool
  default     = true
}
