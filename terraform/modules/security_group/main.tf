# Security Group cho máy Public (chỉ cho phép IP cá nhân SSH)
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Allow SSH from my IP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # IP của bạn
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group cho máy Private (chỉ cho phép máy Public SSH qua)
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow SSH from Public SG only"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}