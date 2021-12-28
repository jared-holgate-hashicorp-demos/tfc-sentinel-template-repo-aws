provider "aws" {
    region = "${var.aws_region}"
}

variable "aws_region" { default = "eu-west-2" } # London

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

# Non-compliant config - Resource created from root module
resource "aws_instance" "bad_ubuntu" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
 
  tags = {
    Name = "non-compliant"
  }
}

output "image_id" {
    value = data.aws_ami.ubuntu.id
}