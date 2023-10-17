variable "user_uuid" {
  description = "The UUID of the user."
  type        = string
  default     = null
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID is not in the expected format (e.g., 123e4567-e89b-12d3-a456-426655440000)."
  }
}

variable "bucket_name" {
  type        = string
  description = "Name for the AWS S3 bucket"

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]{3,63}$", var.bucket_name))
    error_message = "The bucket name must be 3-63 characters long and may only contain alphanumeric characters, hyphens, or periods."
  }
}
