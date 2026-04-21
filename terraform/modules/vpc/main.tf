resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true # Nên bật để EC2 có DNS name
  enable_dns_support   = true

  tags = {
    Name = "Main-VPC"
  }
}