terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "secGroup" {
  name        = "secGroup"
  description = "Allow SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Ec2Instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  security_groups = [aws_security_group.secGroup.name]

  tags = {
    Name = "Ec2Instance"
  }
}