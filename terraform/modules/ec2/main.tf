variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "public_sg" {}
variable "private_sg" {}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "public" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_id

  key_name = "my-key"

  vpc_security_group_ids = [var.public_sg]
}

resource "aws_instance" "private" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = var.private_subnet_id

  key_name = "my-key"

  vpc_security_group_ids = [var.private_sg]
}