terraform {
  cloud {
    organization = "krlab"

    workspaces {
      name = "workflowaction"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
data "aws_ami" "main" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server*"]
  }
}
locals {
  map_ports = {
    ssh = {
        from_port  = 22
        protocol   = "tcp"
        cidr_block = ["0.0.0.0/0"]
    },
    http = {
        from_port  = 80
        protocol   = "tcp"
        cidr_block = ["0.0.0.0/0"]
    },
    https = {
        from_port  = 443
        protocol   = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }
  }
}
/*
module "mynetwork" {
  source  = "app.terraform.io/krlab/network/aws"
  version = "1.0.0"
  cidr_block = "192.168.0.0/20"
  subnet_az = [ "us-west-2a", "us-west-2b" ]
  subnet_cidr = [ "192.168.0.0/24", "192.168.1.0/24" ]
}
module "ec2" {
  source  = "app.terraform.io/krlab/ec2/aws"
  version = "1.0.0"
  vm_type = "t2.micro"
  ami_id = data.aws_ami.main.id
  ec2_az = "us-west-2b"
  ec2_subnet = module.mynetwork.subnet_ids[1] 
  public_key = file("./aws-key.pub")
  map_ports = local.map_ports
  vpc_id = module.mynetwork.aws_vpc_id
}
*/
