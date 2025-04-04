
variable "vpc_id" {}
variable "subnets" {
  type = list(string)
}
variable "target_id" {} # Este es el ARN del Target Group del ASG
variable "sg_id" {}
