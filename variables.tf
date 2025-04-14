variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "topic_name" {
  type        = string
  description = "Name of the Pub/Sub topic to create."
  default     = "miqa-topic"
}

variable "function_name" {
  type        = string
  description = "Name of the Cloud Function to create."
  default     = "miqa-function"
}

variable "publisher_sa_email" {
  type = string
  description = "Service account email to grant Pub/Sub publisher role"
}

variable "function_bucket" {
  type = string
  description = "Name of GCS bucket with function zip"
}

variable "function_zip" {
  type = string
  description = "Path to zip file inside bucket (e.g. runners/function.zip)"
}
