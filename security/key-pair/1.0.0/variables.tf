variable "name" {
  description = "Name of the key pair"
  type        = string

}
variable "ssh_pub_key" {
  description = "SSH public key to use for the key pair"
  type        = string
}
variable "tags" {
  description = "Additional tags for the key pair"
  type        = map(string)
}