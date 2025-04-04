
variable "ami" {}
variable "instance_type" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "user_data" {
  type = string
}
