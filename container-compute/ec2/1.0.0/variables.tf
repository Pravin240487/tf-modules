variable "ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}
variable "stop_protection" {
  type        = bool
  default     = false
  description = "Enable stop protection for the instance"
  
}
variable "delete_protection" {
  type        = bool
  default     = false
  description = "Enable termination protection for the instance"
  
}
variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}
variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile to attach to the instance"
  default     = null
  
}
variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "user_data" {
  type        = string
  default     = ""
  description = "User data script for cloud-init"
}

variable "name" {
  type        = string
  description = "Name tag for the EC2 instance"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags"
}
variable "associate_public_ip" {
  type        = bool
  default     = true
  description = "Whether to associate a public IP"
}
variable "volume_device_name" {
  type        = string
  default     = "/dev/sdh"
  description = "Device name for the EBS volume attachment (e.g., /dev/sdf)"
  
}
variable "ssh_pub_key" {
  type        = string
  description = "SSH public key to use for the instance"
  default     = ""
  
}
variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of root volume"
  type        = string
  default     = "gp3"
}
variable "deletion_on_termination" {
  description = "Delete root volume on termination"
  type        = bool
  default     = true
  
}
variable "availability_zone" {
  type        = string
  description = "Availability Zone for the EBS volume (must match EC2)"
  default     = "eu-central-1a"
}
variable "ebs_volume_size" {
  type        = number
  default     = 50
  description = "Size of the additional EBS volume (GB)"
}
variable "ebs_type" {
  type        = string
  default     = "gp3"
  description = "Type of the EBS volume (e.g., gp2, io1, st1)"
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
variable "enable_ebs_volume" {
  type        = bool
  default     = false
  description = "Enable creation of an additional EBS volume"
}
variable "key_pair_name" {
  type        = string
  description = "Name of the key pair to use for SSH access"
  default     = ""
  
}
variable "http_endpoint" {
  type        = string
  default     = "enabled"
  description = "HTTP endpoint for the instance metadata service"
  
}
variable "http_tokens" {
  type        = string
  default     = "required"
  description = "HTTP tokens for the instance metadata service"
  
}
variable "http_put_response_hop_limit" {
  type        = number
  default     = 1
  description = "HTTP PUT response hop limit for the instance metadata service"
  
}
variable "root_block_device_encrypted" {
  type        = bool
  default     = true
  description = "Whether the root block device should be encrypted"
  
}