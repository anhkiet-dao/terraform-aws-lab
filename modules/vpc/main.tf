resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "Main-VPC" }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  # Inbound: Cho phép traffic nội bộ trong cùng SG này
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  # Outbound: Cho phép tất cả traffic đi ra ngoài
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Main-VPC-Default-SG"
  }
}