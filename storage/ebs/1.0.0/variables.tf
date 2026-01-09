variable "ebs_volume_size" {
  type        = number
  default     = 50
  description = "Size of the additional EBS volume (GB)"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for the EBS volume (must match EC2)"
  default     = "eu-central-1a"

}

variable "ebs_type" {
  type        = string
  default     = "gp3"
  description = "Type of the EBS volume (e.g., gp2, io1, st1)"
  
}
variable "name" {
  type        = string
  description = "Name tag for the EC2 instance"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags"
}
variable "encrypted" {
  type        = bool
  default     = true
  description = "Whether the EBS volume should be encrypted"
  
}
variable "kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key ID for EBS encryption (optional)"
  
}