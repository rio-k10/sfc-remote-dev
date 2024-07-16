variable "name" {
  type = string
  description = "Cloud9 instance name"

}
variable "size" {
  type = string
  default = "c5.xlarge"
  description = "EC2 memory and power capacity"
}

variable "timeout" {
  type = number
  default = 30
  description = "Session timeout in minutes"
}

output "instance_id" {
  value = aws_cloud9_environment_ec2.cloud9_instance.id
  description = "Instance ID of EC2"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID to assign to EC2"
}

variable "region" {
  type = string
  description = "AWS Region"
}