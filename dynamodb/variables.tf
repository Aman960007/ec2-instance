variable "name" {
  description = "Table name."
  type        = string
}

variable "billing_mode" {
  description = "PROVISIONED or PAY_PER_REQUEST"
  type        = string
}


variable "secondary_read_capacity" {
  description = "Secondary index request units per second."
  type        = number
}

variable "secondary_write_capacity" {
  description = "Secondary index request units per second."
  type        = number
}

variable "stream_enabled" {
  description = "Stream enabled feature."
  type        = bool
}

variable "stream_view_type" {
  description = "Stream view type feature."
  type        = string
}


variable "hash_key" {
  description = "key type"
  type        = string
}

variable "secondary_hash_key" {
  description = "key type"
  type        = string
}
