variable "os_type" {
  description = "Operating system type"
  type        = string
}

variable "identifier_publisher" {
  description = "Publisher identifier for the shared image"
  type        = string
}

variable "identifier_offer" {
  description = "Offer identifier for the shared image"
  type        = string
}

variable "identifier_sku" {
  description = "SKU identifier for the shared image"
  type        = string
}

variable "disk_types_not_allowed" {
  description = "List of disk types not allowed"
  type        = string
}

variable "hyper_v_generation" {
  description = "Hyper-V generation"
  type        = string
}

variable "eula" {
  description = "End User License Agreement"
  type        = string
}

variable "specialized" {
  description = "Whether the image is specialized"
  type        = bool
}

variable "regional_replica_count" {
  description = "Regional replica count"
  type        = number
}

variable "storage_account_type" {
  description = "Storage account type"
  type        = string
}

variable "disk_encryption_set_id" {
  description = "Disk encryption set ID"
  type        = string
}

variable "exclude_from_latest_enabled" {
  description = "Exclude from latest enabled flag"
  type        = bool
}
