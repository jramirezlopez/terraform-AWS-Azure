
# Variables principales del proyecto

variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-0c101f26f147fa7fd" # Amazon Linux 2023 (estable)
}

variable "instance_type" {
  default = "t3.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "user_data_path" {
  default = "user_data.sh"
}
