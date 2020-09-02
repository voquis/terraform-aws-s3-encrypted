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

variable "sse_algorithm" {
  description = "Server-side encryption (SSE) algorithm to use"
  type        = string
  default     = "AES256"
}

variable "versioning_enabled" {
  description = "Whether to enable bucket versioning so that deletions and versions are retained"
  type        = bool
  default     = true
}

