terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
   access_key = ANSHGGFDVDBCXRGVBfDFFSFBSBHJSBBS
   secret_key = 7mghgfdVGHFVhgyfdd45g/hvghfdcshgEwecsdA5
   region = ap-south-1
}

# Create a security group allowing incoming traffic on specified ports
resource "aws_security_group" "tf_security" {
  name        = "tf_security"
  description = "terraform security group"

  # Ingress rules (allow incoming traffic)
  # Port 80 (HTTP)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 443 (HTTPS)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 4019
  ingress {
    from_port   = 4019
    to_port     = 4019
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 4018
  ingress {
    from_port   = 4018
    to_port     = 4018
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 5100
  ingress {
    from_port   = 5100
    to_port     = 5100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "terraform_key_pair" {
  key_name   = "terraform_key_pair"
  public_key = file("${path.module}/id_rsa.pub")
}


# Launch an EC2 instance using the specified security group and key pair
resource "aws_instance" "terraform" {
  ami           = "ami-08e5424edfe926b43"  # Replace with your desired AMI ID
  instance_type = "t2.medium"     # Replace with your desired instance type
  key_name      = "${aws_key_pair.terraform_key_pair.key_name}"
  security_groups = [aws_security_group.tf_security.name]

}

# Output the public IP of the instance for reference
output "instance_public_ip" {
  value = aws_instance.terraform.public_ip
}
