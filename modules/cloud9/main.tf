resource "aws_cloud9_environment_ec2" "cloud9_instance" {
  image_id      = "ubuntu-22.04-x86_64"
  name                        = var.name
  instance_type               = var.size
  automatic_stop_time_minutes = var.timeout
  subnet_id = var.subnet_id

  // TODO: ADD CODE FOR REMOTE EXEC OF ENVIRONMENTs

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update",
  #     "sudo apt-get install -y nginx",
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file("~/mykey.pem")
  #     host        = self.public_ip
  #   }
  # }

  tags = {
    Terraform = "true"
  }
}


# EC2 ID
output "id" {
  value = aws_cloud9_environment_ec2.cloud9_instance.id
}

# EC2 ARN
output "arn" {
  value = aws_cloud9_environment_ec2.cloud9_instance.arn
}

# cloud9 url
output "cloud9_url" {
  value = "https://${var.region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.cloud9_instance.id}"
}