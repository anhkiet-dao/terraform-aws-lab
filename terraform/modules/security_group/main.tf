variable "vpc_id" {}

resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["171.253.159.199/32"]
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }
}

output "public_sg" {
  value = aws_security_group.public_sg.id
}

output "private_sg" {
  value = aws_security_group.private_sg.id
}