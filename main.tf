# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}
module "aws_cloud9_vpc" {
  source        = "./modules/vpc"
}

module "aws_cloud9_subnet" {
  source        = "./modules/subnet"
  vpc_id = module.aws_cloud9_vpc.vpc_id
  public_rt_id = module.aws_cloud9_vpc.public_rt_id
}

module "aws_cloud9_environment_ec2" {
  source        = "./modules/cloud9"
  name                        = "skills-for-care-rio"
  subnet_id = module.aws_cloud9_subnet.public_subnet_id
  region = var.region
}

data "aws_security_group" "cloud9_secgroup" {
    filter {
    name = "tag:aws:cloud9:environment"
        values = [
          module.aws_cloud9_environment_ec2.instance_id
        ]
    }
}
resource "aws_security_group_rule" "tcp_8080" {
    type              = "ingress"
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
    security_group_id = data.aws_security_group.cloud9_secgroup.id
}


data "aws_instance" "cloud9_instance" {
    filter {
        name = "tag:aws:cloud9:environment"
        values = [
          module.aws_cloud9_environment_ec2.instance_id
        ]
    }
}


# Create elastic ip
resource "aws_eip" "cloud9_eip" {
    instance = data.aws_instance.cloud9_instance.id
    vpc      = true
}