variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "public_sg" {}
variable "private_sg" {}

resource "aws_instance" "public" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [var.public_sg]
}

resource "aws_instance" "private" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [var.private_sg]
}